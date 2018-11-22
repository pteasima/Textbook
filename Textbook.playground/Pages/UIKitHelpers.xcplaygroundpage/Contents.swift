import UIKit

public extension UITableView {
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        register(Cell.self, forCellReuseIdentifier: NSStringFromClass(Cell.self))
        return dequeueReusableCell(withIdentifier: NSStringFromClass(Cell.self), for: indexPath) as! Cell
    }
}

public struct Constraint {
    let create: (_ parent: UIView, _ child: UIView) -> NSLayoutConstraint
    
    public static func equal<Anchor, Axis>(_ anchor: @escaping (UIView) -> Anchor, constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return .init { parent, child in
            return anchor(parent).constraint(equalTo: anchor(child))
        }
    }
    
    public static func fillParent() -> [Constraint] {
        return [
            .equal(get(\.leadingAnchor)),
            .equal(get(\.trailingAnchor)),
            .equal(get(\.topAnchor)),
            .equal(get(\.bottomAnchor))
        ]
    }
}


public extension UIView {
    public func addSubview(_ subview: UIView, constraints: [Constraint] = []) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            constraints.map { $0.create(self, subview) }
        )
    }
}

// The End🙈
_delimiter = "🙈"
environment.savePage("UIKitHelpers.swift")
