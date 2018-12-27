import Foundation
import PlaygroundSupport
import UIKit
public var _delimiter: Character = "…" //dont forget to overwrite this

let repoName = "Textbook"
let playgroundName = "Math"

extension String {
    var escaped: String {
        return addingPercentEncoding(withAllowedCharacters: .init())!
    }
    func link(named: String) -> String {
        return "[\(named)](\(self))"
    }
}

private func write(text: String, to file: String, in repo: String) -> String {
    return "working-copy://x-callback-url/write?key=112567&repo=\(repo.escaped)&mode=overwrite&path=\((playgroundName + ".playground/Sources/" + file).escaped)&clipboard=no&text=\(text.escaped)"
}
public struct Environment {
    public var savePage: (String) -> Void = { filename in
        PlaygroundPage.current.assessmentStatus = .pass(message: write(
            text: String(PlaygroundPage.current.text.prefix { $0 != _delimiter }),
            to: filename,
            in: repoName
        ).link(named: "Save to \(filename)"))
    }
    public var setLiveView: (PlaygroundLiveViewable) -> Void = { PlaygroundPage.current.liveView = $0 }
    public var now = { Date() }
    public var locale = Locale()
    public var database = Database()
    public var ask: (String, [String], @escaping (Int) -> Void) -> Void = { question, answers, completion in
        let alert = with(UIAlertController(title: nil, message: question, preferredStyle: answers.count > 2 ? .actionSheet : .alert),
             { (alert: inout UIAlertController) in
                answers.enumerated().forEach {
                    let (index, answer) = $0
                    alert.addAction(UIAlertAction(title: answer, style: .default) { _ in completion(index) })
                }
                })
        if let rootVC = PlaygroundPage.current.liveView as? UIViewController {
            rootVC.present(alert, animated: true)
        }else {
            PlaygroundPage.current.liveView = alert
        }
        }
    }


public var environment = Environment()
// The End 