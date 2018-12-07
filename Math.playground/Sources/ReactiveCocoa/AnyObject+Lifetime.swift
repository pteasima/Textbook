import Foundation


public extension Lifetime {
	/// Retrive the associated lifetime of given object.
	/// The lifetime ends when the given object is deinitialized.
	///
	/// - parameters:
	///   - object: The object for which the lifetime is obtained.
	///
	/// - returns: The lifetime ends when the given object is deinitialized.
	public static func of(_ object: NSObject) -> Lifetime {
	return .of(object)
   }
}
extension Reactive where Base: NSObject {
	/// Returns a lifetime that ends when the object is deallocated.
	@nonobjc public var lifetime: Lifetime {
		return .of(base)
	}
}
