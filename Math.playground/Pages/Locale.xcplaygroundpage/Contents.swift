import Foundation
public struct Locale {
    public init() {}
    public var formatted: (Date) -> String = formatter.string(from:)
}
private let formatter = with(DateFormatter(), concat(
    mut(\.dateStyle, .medium),
    mut(\.timeStyle, .full)
    ))

// The End 🙈
_delimiter = "🙈"
environment.savePage("Locale.swift")
