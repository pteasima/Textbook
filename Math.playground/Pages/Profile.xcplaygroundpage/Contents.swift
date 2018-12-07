import UIKit
extension NSObject: ReactiveExtensionsProvider {}
extension UIView {
    @objc func handleTap() {
        print("tap")
        state.modify(concat(
            mut(\.user.grade, .one),
            mut(\.user.name, "him")
        ))
    }
}

enum Grade: String {
    case one
    case two
}

struct User {
    var name: String
    var grade: Grade
}
struct State {
    var user: User
}
let state: MutableProperty<State> = .init(.init(user: .init(name: "me", grade: .two)))
let reactiveLabel = Rendering<Property<String>, UILabel> { text in
    return with(UILabel()) { (label: inout UILabel) in
        /*label.reactive[\.text] <~
            MutableProperty("foo")*/
        text.producer.startWithValues { [weak label] in label?.text = $0 }
    }
} 
.map { (l: UILabel) -> UILabel in
    l.addGestureRecognizer(UITapGestureRecognizer(target: l, action: #selector(UIView.handleTap)))
    l.isUserInteractionEnabled = true
        return l 
}
let nameLabel = reactiveLabel
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))
let grade = reactiveLabel
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))

let profile: Rendering<Property<User>, UIStackView> = stack([
    nameLabel.pullback {
        $0.map(get(\.name))
    },
    grade
    .pullback { $0.map(get(\User.grade.rawValue)) }
    ].map { $0.map { $0 }})
    .map(set(\.axis, .vertical))


//let state = MutableProperty(User(name: "me", grade: .one))
environment.setLiveView(profile.render(state.map(get(\.user))))/*, then: SignalProducer.timer(interval: DispatchTimeInterval.seconds(5), on: QueueScheduler.main).map { _ in User(name: "him", grade: .two)})))*/


