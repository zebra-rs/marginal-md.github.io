// Posts a left click at screen coordinates (points, origin top-left), then
// parks the pointer at a second point so hover states don't show in shots.
//   click <x> <y> [parkX parkY]
import CoreGraphics
import Foundation

let a = CommandLine.arguments
guard a.count >= 3, let x = Double(a[1]), let y = Double(a[2]) else {
  FileHandle.standardError.write("usage: click x y [parkX parkY]\n".data(using: .utf8)!)
  exit(2)
}
let src = CGEventSource(stateID: .hidSystemState)
func post(_ type: CGEventType, _ p: CGPoint) {
  CGEvent(mouseEventSource: src, mouseType: type, mouseCursorPosition: p, mouseButton: .left)?.post(tap: .cghidEventTap)
}
let p = CGPoint(x: x, y: y)
post(.mouseMoved, p); usleep(60_000)
post(.leftMouseDown, p); usleep(70_000)
post(.leftMouseUp, p); usleep(60_000)
if a.count >= 5, let px = Double(a[3]), let py = Double(a[4]) { post(.mouseMoved, CGPoint(x: px, y: py)) }
