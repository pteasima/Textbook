import UIKit
import PlaygroundSupport

public final class DatesListViewController: UITableViewController {
    public var dates = [
        environment.now(),
        environment.now().addingTimeInterval(1),
        ] {
        didSet { tableView.reloadData() }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return with(tableView.dequeueCell(for: indexPath), mut(\.textLabel!.text, dates.map(String.init(describing:))[indexPath.row]))
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        environment.flow.goToDateDetail(.init(date: dates[indexPath.row]))
    }
}
environment.setLiveView(DatesListViewController())

// The End 🙈
_delimiter = "🙈"
environment.savePage("DatesList.swift")
