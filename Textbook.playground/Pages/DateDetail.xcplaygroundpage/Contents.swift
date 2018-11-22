import UIKit

final class DateDetailViewController: UIViewController {
    var state: State.DateDetail = environment.flow.loadDateDetailState() {
        didSet {
            guard isViewLoaded else { return }
            update()
        }
    }
    
    let label = UILabel()
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(label, constraints: Constraint.fillParent())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        label.text = environment.locale.formatted(state.date)
    }
}

environment.setLiveView(DateDetailViewController())
