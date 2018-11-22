import UIKit
import PlaygroundSupport

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
        //environment.flow.goToDateDetail(.init(date: dates[indexPath.row]))
    }
}
// The End 🙈
_delimiter = "🙈"
environment.setLiveView(UsersListViewController())
environment.savePage("UsersList.swift")
