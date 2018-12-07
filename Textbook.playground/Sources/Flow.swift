import Foundation
import PlaygroundSupport

public struct Flow {
    public init() {}
    
    public var goToPageNamed: (String) -> Void = { _ in
//        PlaygroundPage.current.assessmentStatus = .pass(message: "Go to [\($0)](\($0))")
    }
    
    public var goToDateDetail: (State.DateDetail) -> Void = { state in
//        PlaygroundKeyValueStore.current["DateDetail"] = try! encode(state)
        environment.flow.goToPageNamed("DateDetail")
    }
    
    public var loadDateDetailState: () -> State.DateDetail = {
      fatalError()
//        return PlaygroundKeyValueStore.current["DateDetail"].flatMap { try? decode(State.DateDetail.self, from: $0) } ?? .init(date: environment.now())
    }
}

// The End 
