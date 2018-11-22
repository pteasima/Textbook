import Foundation
import PlaygroundSupport

public struct State {
    public struct DateDetail: Codable {
        public init(date: Date) {
            self.date = date
        }
        public let date: Date
    }
}

// The End 🙈
_delimiter = "🙈"
environment.savePage("State.swift")
