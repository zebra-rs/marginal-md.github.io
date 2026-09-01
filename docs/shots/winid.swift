// Prints the on-screen windows of an app as "<CGWindowID>\t<layer>\t<WxH>\t<title>".
// Used by shoot.sh to find the Marginal window for `screencapture -l`.
import CoreGraphics
import Foundation

let want = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "Marginal"
let list = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as! [[String: Any]]
for w in list {
  guard (w["kCGWindowOwnerName"] as? String) == want else { continue }
  let num = w["kCGWindowNumber"] as? Int ?? 0
  let layer = w["kCGWindowLayer"] as? Int ?? 0
  let name = w["kCGWindowName"] as? String ?? ""
  let b = w["kCGWindowBounds"] as? [String: Any] ?? [:]
  print("\(num)\t\(layer)\t\(b["Width"] ?? 0)x\(b["Height"] ?? 0)\t\(name)")
}
