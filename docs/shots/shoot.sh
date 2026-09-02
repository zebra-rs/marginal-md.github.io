#!/bin/bash
# Screenshots of the real Marginal app for the manual. macOS only.
#
#   docs/shots/shoot.sh [light|dark|both]        (default: both)
#
# Copies the fixture workspace to /Users/Shared/Notes (a path with no user
# name in it — it also carries a Claude Code and a Codex layout, for the
# coding-agent scenes), launches /Applications/Marginal.app on it with a fixed window
# size, drives it through its menus and accessibility tree via System
# Events, captures the window with `screencapture -l`, and writes Retina
# PNGs to src/assets/shots/: <scene>.png for the light appearance,
# <scene>-dark.png for the dark one.
#
# The app must not be running (it is single-instance). Its config directory
# is backed up first, the recent-file lists are blanked for the run, and the
# backup is restored afterwards — the window size, recent files, workspace
# and settings you actually use are untouched. Sign-in state is kept, so
# the shots show a licensed app.
#
# Needs Screen Recording and Accessibility permission for the terminal that
# runs this. Set MARGINAL_APP to another .app bundle to shoot a different build.

set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
APP_BUNDLE="${MARGINAL_APP:-/Applications/Marginal.app}"
APP="$APP_BUNDLE/Contents/MacOS/marginal"
OUT="${SHOTS_OUT:-$HERE/../src/assets/shots}"
FIXTURE="$HERE/fixture"
WORK="/Users/Shared/Notes"
CONF="$HOME/Library/Application Support/md.marginal"
W=1280
H=800

mode="${1:-both}"
case "$mode" in light|dark|both) ;; *) echo "usage: $0 [light|dark|both]" >&2; exit 2 ;; esac

# ---------- helpers ----------------------------------------------------------

say() { printf '\033[1m%s\033[0m\n' "$*"; }
die() { printf 'shoot: %s\n' "$*" >&2; exit 1; }
nap() { perl -e "select(undef, undef, undef, $1)"; }

# Run one System Events statement against the Marginal process.
se() { osascript -e "tell application \"System Events\" to tell process \"Marginal\" to $1" >/dev/null; }
# Keystrokes go to the frontmost app whatever the `tell` says, and the window
# loses key status after a capture — so bring Marginal forward before each one.
# Through System Events, not `tell application "Marginal" to activate`: that
# goes via LaunchServices and, for an app started from its binary, takes the
# main window off screen about two seconds later (observed 2026-09-01).
focus() { se "set frontmost to true"; nap 0.3; }

# Prefer menu items over keystrokes: a shortcut can be consumed by the editor
# (⌘⇧K is CodeMirror's delete-line) or handled twice when focus is elsewhere.
# menu <menu title> <item title>   e.g. menu View "Toggle Sidebar"
menu() { focus; se "click menu item \"$2\" of menu \"$1\" of menu bar 1"; nap 0.6; }
esc() { focus; se "key code 53"; nap 0.4; }
type_text() { focus; se "keystroke \"$1\""; nap 0.4; }
# key <character> [cmd] [shift] [option] [control] — for things without a menu item
key() {
  local k="$1"; shift
  local mods="" m
  for m in "$@"; do
    case "$m" in
      cmd|command) m=command ;; opt|option|alt) m=option ;;
      ctrl|control) m=control ;; shift) m=shift ;;
      *) die "unknown modifier $m" ;;
    esac
    mods="${mods:+$mods, }$m down"
  done
  focus
  if [ -n "$mods" ]; then se "keystroke \"$k\" using {$mods}"; else se "keystroke \"$k\""; fi
  nap 0.4
}

# click_in_window <x> <y> — a mouse click at window-relative points, posted
# as a CoreGraphics event by the `click` helper (System Events' own `click at`
# is not implemented on current macOS). The webview exposes no usable
# accessibility tree to System Events, so anything without a menu item or
# shortcut is reached this way. The pointer is parked on the title bar after.
click_in_window() {
  focus
  local pos wx wy
  pos="$(osascript -e 'tell application "System Events" to tell process "Marginal" to get position of (first window whose name contains "Marginal")')"
  wx="${pos%%,*}"; wy="${pos##*, }"
  "$HERE/click" $((wx + $1)) $((wy + $2)) $((wx + W / 2)) $((wy + 10))
  nap 0.5
}

# settings_tab <Account|General|Appearance|Editor|Preview|AI>
# The Settings panel is centred in the window, so at 1280×800 its category
# strip sits at these window-relative points. Re-measure if the panel moves.
settings_tab() {
  local y
  case "$1" in
    Account) y=201 ;; General) y=234 ;; Appearance) y=267 ;;
    Editor) y=301 ;; Preview) y=334 ;; AI) y=367 ;;
    *) die "unknown settings tab: $1" ;;
  esac
  click_in_window 330 "$y"
}

winid() { "$HERE/winid" Marginal | awk -F"\t" '$2 == 0 && !done { print $1; done = 1 }'; }

# The window occasionally drops out of the on-screen list for a moment —
# look a few times before giving up.
wait_winid() {
  local id="" _
  for _ in 1 2 3 4 5 6; do id="$(winid)"; [ -n "$id" ] && { echo "$id"; return 0; }; nap 0.5; done
  echo "shoot: no on-screen Marginal window; all windows:" >&2
  "$HERE/winid" Marginal >&2
  return 1
}

shot() {
  nap 0.8
  local id; id="$(wait_winid)" || die "lost the Marginal window before '$1'"
  screencapture -l "$id" -o -x "$OUT/$1$suffix.png"
  say "  $1$suffix.png"
}

# run_app <appearance> <fit|fixed> [args…]
run_app() {
  local appearance="$1" sizing="$2"; shift 2
  pgrep -f "$APP" >/dev/null && die "Marginal is running — quit it first (it is single-instance)"
  # Through LaunchServices, not the binary: an app started from its binary
  # takes its window off screen two seconds after any LaunchServices
  # activation (observed 2026-09-01).
  open -a "$APP_BUNDLE" --args --appearance "$appearance" "$@"
  for _ in $(seq 1 40); do [ -n "$(winid)" ] && break; nap 0.5; done
  [ -n "$(winid)" ] || die "no Marginal window appeared"
  focus
  se "set position of (first window whose name contains \"Marginal\") to {40, 40}"
  [ "$sizing" = fixed ] && se "set size of (first window whose name contains \"Marginal\") to {$W, $H}"
  nap 1.5
}

quit_app() {
  pgrep -f "$APP" >/dev/null || return 0
  osascript -e 'tell application "Marginal" to quit' >/dev/null 2>&1 || true
  for _ in $(seq 1 30); do pgrep -f "$APP" >/dev/null || return 0; nap 0.5; done
  pkill -f "$APP" || true
}

BAK=""
backup_conf() {
  BAK="$(mktemp -d)"
  [ -d "$CONF" ] && cp -R "$CONF" "$BAK/md.marginal"
  # Blank the recent-file/folder lists so the Welcome screen and the Open
  # Recent menus show nothing of yours, and shoot with the default coding
  # agent and folded sections. (Restored with the rest afterwards.)
  [ -f "$CONF/settings.json" ] || echo '{}' > "$CONF/settings.json"
  python3 - "$CONF/settings.json" "$WORK" <<'PY'
import json, sys
path = sys.argv[1]
with open(path) as f:
    d = json.load(f)
for k, v in list(d.items()):
    if "recent" in k.lower() and isinstance(v, list):
        d[k] = []
d["lastWorkspace"] = sys.argv[2]
d["codingAgent"] = "claude-code"
d["unfoldAgentSections"] = False
with open(path, "w") as f:
    json.dump(d, f, indent=2)
PY
  # Open at the shot size from the first frame (physical pixels on a 2× display).
  printf '{"main":{"width":%d,"height":%d,"x":80,"y":80,"maximized":false,"visible":true,"decorated":true,"fullscreen":false}}\n' \
    $((W * 2)) $((H * 2)) > "$CONF/.window-state.json"
  return 0
}
# set_pref <key> <json value> — patch one setting for the next launch, e.g.
# set_pref codingAgent '"codex"' or set_pref unfoldAgentSections true. The
# backup restores the real value afterwards.
set_pref() {
  python3 - "$CONF/settings.json" "$1" "$2" <<'PY'
import json, sys
path, key, value = sys.argv[1], sys.argv[2], json.loads(sys.argv[3])
with open(path) as f:
    d = json.load(f)
d[key] = value
with open(path, "w") as f:
    json.dump(d, f, indent=2)
PY
}
restore_conf() {
  [ -n "$BAK" ] || return 0
  if [ -d "$BAK/md.marginal" ]; then rsync -a --delete "$BAK/md.marginal/" "$CONF/"; fi
  rm -rf "$BAK"; BAK=""
}
cleanup() { quit_app; restore_conf; rm -rf "$WORK"; }
trap cleanup EXIT

# ---------- scenes -----------------------------------------------------------
# Add a scene: reach the state with menu/settings_tab/type_text/key, then
# `shot <name>`. Keep names stable — the manual references them by file name.

scenes_workspace() {
  # Launch opens the Notes workspace with Welcome.md in a tab.
  menu View Split;                   shot editor-split
  menu View "Editor Only";           shot editor-only
  menu View "Preview Only";          shot preview-only
  menu View Split

  menu View "Go to File…";           shot go-to-file
  esc
  menu View "Command Palette…";      shot command-palette
  esc

  menu View "Filter Files"; type_text "notes"
                                     shot filter-files
  esc; esc

  menu View "Fold All Sections";     shot fold-all
  menu View "Unfold All Sections"

  menu View Terminal;                shot terminal
  menu View Terminal

  # The AI bar expands an empty selection to the block at the cursor.
  menu AI "Edit Selection…";         shot ai-edit
  esc
  menu AI "Ask About Selection…";    shot ai-ask
  esc

  menu Marginal "Settings…";         shot settings-general
  settings_tab Appearance;           shot settings-appearance
  settings_tab Editor;               shot settings-editor
  settings_tab Preview;              shot settings-preview
  settings_tab AI;                   shot settings-ai
  esc
}

# The fixture carries both a Claude Code layout (CLAUDE.md, .claude/…) and a
# Codex one (AGENTS.md, .agents/skills/…); the same folder is shot once per
# agent, with the sections unfolded through the pref rather than by clicking
# five headers.
scenes_agents() {
  shot "$1"
}

scenes_welcome() {
  shot welcome
}

scenes_reader() {
  shot reader
}

# ---------- run ---------------------------------------------------------------

[ -x "$APP" ] || die "app not found at $APP_BUNDLE (set MARGINAL_APP)"
[ -x "$HERE/winid" ] || { say "building winid…"; swiftc -O -o "$HERE/winid" "$HERE/winid.swift" 2>/dev/null; }
[ -x "$HERE/click" ] || { say "building click…"; swiftc -O -o "$HERE/click" "$HERE/click.swift" 2>/dev/null; }
mkdir -p "$OUT"
rm -rf "$WORK" && cp -R "$FIXTURE" "$WORK"

for appearance in $([ "$mode" = both ] && echo "light dark" || echo "$mode"); do
  suffix=""; [ "$appearance" = dark ] && suffix="-dark"
  say "▶ $appearance"
  backup_conf
  run_app "$appearance" fixed "$WORK" "$WORK/Welcome.md"
  scenes_workspace
  quit_app
  set_pref unfoldAgentSections true
  run_app "$appearance" fixed "$WORK" "$WORK/Welcome.md"
  scenes_agents agent-sections
  quit_app
  set_pref codingAgent '"codex"'
  run_app "$appearance" fixed "$WORK" "$WORK/Welcome.md"
  scenes_agents agent-sections-codex
  quit_app
  set_pref codingAgent '"claude-code"'
  set_pref unfoldAgentSections false
  run_app "$appearance" fixed "$WORK"
  scenes_welcome
  quit_app
  run_app "$appearance" fit --reader "$WORK/Reading list.md"
  scenes_reader
  quit_app
  restore_conf
done
say "done → $OUT"
