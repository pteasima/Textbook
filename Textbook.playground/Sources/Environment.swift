import Foundation
import PlaygroundSupport
public var _delimiter: Character = "…" //dont forget to overwrite this

let repoName = "Textbook"

extension String {
    var escaped: String {
        return addingPercentEncoding(withAllowedCharacters: .init())!
    }
    func link(named: String) -> String {
        return "[\(named)](\(self))"
    }
}

private func write(text: String, to file: String, in repo: String) -> String {
    return "working-copy://x-callback-url/write?key=112567&repo=\(repo.escaped)&mode=overwrite&path=\((repo + ".playground/Sources/" + file).escaped)&clipboard=no&text=\(text.escaped)"
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
    public var flow = Flow()
    public var locale = Locale()
    public var database = Database()
}

public var environment = Environment()
// The End 