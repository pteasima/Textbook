import Foundation
import PlaygroundSupport
//extension PlaygroundKeyValueStore {
//     subscript<T: Codable>(_ key: Database.Key) -> T? {
//        get { return self[key.rawValue].flatMap { try? decode(T.self, from: $0) } }
//        set { self[key.rawValue] = try? encode(newValue) }
//    }
//}
public struct Database {
    public init() {}
    enum Key: String {
        case users
    }
    public var getUsers: () -> [User] = {
        /*PlaygroundKeyValueStore.current[.users] ?? */[]
    }
    public var upsertUser: (User) -> Void = { newUser in //TODO: some lens magic
       /* _ = with(PlaygroundKeyValueStore.current, mver(\.[.users]) { (users: inout [User]?) in
            if let existingIndex = users?.firstIndex(where: { $0.id == newUser.id }) {
                users?[existingIndex] = newUser
            } else {
                users?.append(newUser)
            }
        })*/
    }
}

// The End 
