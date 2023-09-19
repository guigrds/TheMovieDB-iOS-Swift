import Foundation

typealias Params = [String: String]
typealias Response<T: Decodable> = (Result<T>) -> ()
