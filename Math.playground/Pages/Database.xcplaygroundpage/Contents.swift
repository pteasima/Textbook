import Foundation
import PlaygroundSupport
func readFromPlayground<T:Decodable>(_ key: String) -> Result<T?, DecodingError> {
    return Result {
        try PlaygroundKeyValueStore.current[key].flatMap{ try decode(T.self, from: $0) }
    }
}
func writeToPlayground<T: Encodable>(_ key: String, _ value: T?) {
    PlaygroundKeyValueStore.current[key] = try! encode(value)
}
public enum Record<A> {}
public struct Query<A> {
    let perform: () -> Result<A?, DecodingError>
    
    func combined<B>(with other: Query<B>) -> Query<(A,B)> {
        return query
    }
}
public struct Database {
    public enum Schema {
        var users: Record<[User]> { switch self { } }
        //var currentUserID: ID? { switch self { } }
    }
    func read<T: Decodable>(_ keyPath: KeyPath<Schema, Record<T>>) -> Query<T> {
        return .init { readFromPlayground(String(describing: keyPath)) }
    }
    
    public var currentUser: () -> Result<User?, DecodingError> = {
        fatalError()
        //return read("currentUser")
    }
    public var setCurrentUser: (User?) -> () = { writeToPlayground("currentUser", $0) }
}

extension Database.Schema {
    //public var currentUser: Query<User> 
}

// The End 🙈
_delimiter = "🙈"
environment.savePage("Database.swift")

