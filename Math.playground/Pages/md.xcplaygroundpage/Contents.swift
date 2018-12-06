import Foundation
import PlaygroundSupport
import UIKit

extension Environment: ReactiveExtensionsProvider { }
public extension Reactive where Base == Environment {
    public subscript<A, B>(userConfirmed keyPath: KeyPath<Base, (A) -> B>) -> (A) -> SignalProducer<B, NoError> {
        get {
            return { a in
                let pipe = Signal<B, NoError>.pipe()
                let producer = pipe.output.producer
                let fullfil = {
                    pipe.input.send(value: self.base[keyPath: keyPath](a))
                    pipe.input.sendCompleted()
                }
                guard case .step = PlaygroundPage.current.executionMode else {
                    guard case .stepSlowly = PlaygroundPage.current.executionMode else {fatalError()
                    }
                    fullfil(); return producer
                }
                environment.ask("Do you want to trigger sideffect \(keyPath) with arguments: \(a)?", ["Yes", "No, Im a pussy"]) {
                    if $0 == 0 {
                        fullfil()
                    } else {
                        pipe.input.sendInterrupted()
                    }
                }
                return producer
            }
        }
    }
    
}

func say(_ input: String) -> Void {
    input
}


say("whaaa")
environment.setLiveView(UIViewController())
environment.reactive[userConfirmed: \.savePage]("Test").startWithValues {
    $0
}
