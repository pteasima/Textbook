import UIKit
import PlaygroundSupport
protocol WorldEnvironment { }
extension WorldEnvironment {
    public subscript<Value>(keyPath keyPath: WritableKeyPath<Environment, Value>) -> Value {
        get { return environment[keyPath: keyPath] }
        set { environment[keyPath: keyPath] = newValue }
    } 
}
public struct Chapter: WorldEnvironment {
    public var loadUsers: () -> [User] = { [] }
}

protocol ChapterEnvironment: WorldEnvironment {}
extension ChapterEnvironment {
    public subscript<Value>(keyPath keyPath: WritableKeyPath<Chapter, Value>) -> Value {
        get { return chapter[keyPath: keyPath] }
        set { chapter[keyPath: keyPath] = newValue }
    } 
}
var chapter = Chapter()
struct Page: ChapterEnvironment {
    var didSelectUser: (User) -> Void = { print($0) }
    
}
var page = Page()

public final class UsersListViewController: UITableViewController {
    public var users: [User] = [] {
        didSet { tableView.reloadData() }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return with(tableView.dequeueCell(for: indexPath), mut(\.textLabel!.text, users.map(String.init(describing:))[indexPath.row]))
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let x = page[keyPath: \.loadUsers]()
        let y = page[keyPath: \.flow]
        //environment.flow.goToDateDetail(.init(date: dates[indexPath.row]))
    }
}
// The End 🙈
_delimiter = "🙈"
environment.setLiveView(UsersListViewController())
environment.savePage("UsersList.swift")
