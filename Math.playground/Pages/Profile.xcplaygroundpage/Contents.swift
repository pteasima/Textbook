import UIKit

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

let nameLabel : Rendering<User, UILabel> = simpleLabel
    .pullback(get(\User.name))
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))
let grade: Rendering<User, UILabel> = simpleLabel
    .pullback(compose(get(\Grade.rawValue),get(\User.grade)))
    .map(concat(
        set(\.frame, CGRect(origin:.zero, size: CGSize(width: 100, height: 100))),
        set(\.backgroundColor, .white)
    ))

let profile: Rendering<User, UIStackView> = stack([nameLabel, grade].map { $0.map { $0 }})
    .map(set(\.axis, .vertical))


environment.setLiveView(profile.render(User(name: "me", grade: .one)))
