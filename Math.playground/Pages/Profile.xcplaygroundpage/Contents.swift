import UIKit
//extension NSObject: ReactiveExtensionsProvider {}

final class Label: UILabel {
    //cant quite get full power of ReactiveCocoa in a Playground because of ObjC
    var onTap: () -> Void = { }
    @objc func handleTap() {
        onTap()
    }
}

struct State {
    var user: User
}
let state: MutableProperty<State> = .init(.init(user: .mock))
let x: SignalProducer<User?, DecodingError> = environment.database["currentUser"]
//state <~ environment.database["currentUser"].map { (u: User?) in u! }.map(State.init(user:))
let reactiveLabel = Rendering<Property<String>, Label> { text in
    return with(Label()) { (label: inout Label) in
        //crashes the playground
        //label.reactive[\.text] <~ text.signal
        text.producer.startWithValues { [weak label] in label?.text = $0 }
    }
} 
.map { (l: Label) -> Label in
    l.addGestureRecognizer(UITapGestureRecognizer(target: l, action: #selector(Label.handleTap)))
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
        set(\.backgroundColor, .white),
        set(\.onTap) { 
            state.modify(
            mver(\.user.grade) { $0.toggle() })
            environment.database["currentUser"] =  state.value.user
        }
        
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
environment.setLiveView(navigationController(rootViewController: viewController(rootView: profile.map { $0 })).render(state.map(get(\.user))))/*, then: SignalProducer.timer(interval: DispatchTimeInterval.seconds(5), on: QueueScheduler.main).map { _ in User(name: "him", grade: .two)})))*/


