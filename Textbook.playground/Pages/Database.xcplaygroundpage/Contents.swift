import Foundation
import PlaygroundSupport

extension PlaygroundKeyValueStore {
     subscript(_ key: Database.Key) -> PlaygroundValue? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue }
    }
}
public struct Database {
    public init() {}
    enum Key: String, CaseIterable {
        case users
    }
    public var getUsers: () -> [User] = {
        PlaygroundKeyValueStore.current[.users].flatMap { try? decode([User].self, from: $0) } ?? []
    }
    public var upsertUser: (User) -> Void = { newUser in //TODO: some lens magic
        /*_ = with(PlaygroundKeyValueStore.current, pipe(over(\.[.users]!), map(String.init(describing:))) { (users: String) -> String in
            fatalError()
            /*if let existingIndex = users?.firstIndex(where: { $0.id == newUser.id }) {
                users?[existingIndex] = newUser
            } else {
                users?.append(newUser)
            }*/ []
        })*/
    }
    /*
    public var clear: () -> Void = {
        Key.allCases.forEach { key in
            _ = with(PlaygroundKeyValueStore.current, mver(\.[key]) { (values: inout [Any]?) in 
                values = nil
            }))
        }
    }*/
}


// The End 🙈
_delimiter = "🙈"
environment.savePage("Database.swift")
