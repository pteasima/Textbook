import Foundation
public struct User: Codable {
    public init(name: String, role: Role = .member) {
        self.name = name
        self.role = role
    }
    
    public enum Role: String, Codable {
        case admin
        case member
    }
    
    public let name: String
    public var role: Role
    
    public var id: String { return name }
}
public extension User {
    public static let martin = User(name: "Martin", role: .admin)
    public static let mara = User(name: "Mara")
}

// The End 🙈
_delimiter = "🙈"
environment.savePage("Model.swift")
