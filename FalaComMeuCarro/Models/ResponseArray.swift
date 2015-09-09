import Foundation
import ObjectMapper

class ResponseArray<T: Mappable>: Mappable {
	
	var errorCode: Int!
	var message: [String]!
	var data: [T]!
	
	static func newInstance(map: Map) -> Mappable? {
		return ResponseArray<T>()
	}
	
	func mapping(map: Map) {
		errorCode <- map["error_code"]
		message <- map["message"]
		data <- map["data"]
	}
}