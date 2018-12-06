import UIKit

public struct Rendering<A, View> {
    public let render: (A) -> View
    public init(render: @escaping(A) -> View) { self.render = render }
    public func pullback<T>(_ transform: @escaping (T) -> A) -> Rendering<T, View> {
        return .init { self.render(transform($0)) }
    }
    
    public func map<NewView>(_ transform: @escaping (View) -> NewView) -> Rendering<A, NewView> {
        return .init { transform(self.render($0)) }
    }
}

public let simpleLabel: Rendering<String, UILabel> = .init {
    with(UILabel(), mut(\.text, $0))
}
public let simpleButton: Rendering<String, UIButton> = .init { 
    with(UIButton(), mut(\.title, $0))
}
public func stack<A>(_ views: [Rendering<A, UIView>]) -> Rendering<A, UIStackView> {
    return .init { model in
        UIStackView(arrangedSubviews: views.map { $0.render(model) })
    }
}
//TODO: get rid of casts by:
// - at least adding a generic to handle array of any view
// - geeting rid of array and defining/generating multiple functions with typed args
// - seeing if Combining can someh
let twoLabels = stack([simpleLabel, simpleLabel].map { $0.map { $0 } })


// The End