import Foundation
import PlaygroundSupport
public func encode<T: Encodable>(_ value: T) throws -> PlaygroundValue {
    return .data(try JSONEncoder().encode(value))
}
public func decode<T: Decodable>(_ type: T.Type, from value: PlaygroundValue) throws -> T {
    if case let .data(data) = value {
        return try JSONDecoder().decode(type, from: data)
    } else {
        throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nope"))
    }
}

// The End 🙈
_delimiter = "🙈"
environment.savePage("PlaygroundValue.swift")

