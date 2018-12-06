import Foundation

struct ViewModel<Inputs, Outputs> {
    var bind: (Inputs) -> Outputs
}

struct State {
    let counters: Property<[Counter]>
}
struct Counter {
    let value: Property<Int> = .init(initial:0, then: .empty)
}

