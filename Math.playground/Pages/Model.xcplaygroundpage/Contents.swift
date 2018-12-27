public typealias ID = String
public struct User: Codable {
    public var id: ID { return name }
    public var name: String
    public var grade: Grade
    
    public static var mock: User {
        return .init(name: "Tomas Fuk", grade: .one)
    }
}
public enum Grade: String, Codable {
    case one
    case two
    
    public mutating func toggle() {
        switch self {
        case .one: self = .two
        case .two: self = .one
        }
    }
}


// The End 


// The End 🙈
_delimiter = "🙈"
environment.savePage("Model.swift")
