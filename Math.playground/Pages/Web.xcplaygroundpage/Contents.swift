import UIKit
import SafariServices
import PlaygroundSupport


//# runs a web browser
environment.setLiveView(SFSafariViewController(url: URL(string: "https://markdownlivepreview.com/")!))

UIPasteboard.general.string = PlaygroundPage.current.text.replacingOccurrences(of: "//", with: "").replacingOccurrences(of: "/*", with: "").replacingOccurrences(of: "*/", with: "")

