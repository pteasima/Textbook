import UIKit
import PlaygroundSupport

final class DatesListViewController: UITableViewController {
    var dates = [
        environment.now(),
        environment.now().addingTimeInterval(1),
        ] {
        didSet { tableView.reloadData() }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return with(tableView.dequeueCell(for: indexPath), mut(\.textLabel!.text, dates.map(String.init(describing:))[indexPath.row]))
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        environment.flow.goToDateDetail(.init(date: dates[indexPath.row]))
    }
}
environment.setLiveView(DatesListViewController())


