import UIKit
extension NSObject: ReactiveExtensionsProvider {}
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

let reactiveLabel = Rendering<Property<String>, UILabel> { text in
    return with(UILabel()) { (label: inout UILabel) in
        label.reactive[\.text] <~
            MutableProperty("foo")
    }
} 

let nameLabel = simpleLabel
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))
let grade = simpleLabel
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))

let profile: Rendering<Property<User>, UIStackView> = stack([
    nameLabel.pullback(get(\.value.name)),
    grade.pullback(compose(get(\Grade.rawValue),get(\User.grade), get(\.value))),
    ].map { $0.map { $0 }})
    .map(set(\.axis, .vertical))


environment.setLiveView(profile.render(Property(initial: User(name: "me", grade: .one), then: SignalProducer.timer(interval: DispatchTimeInterval.seconds(1), on: QueueScheduler.main).map { _ in User(name: "him", grade: .two)})))
