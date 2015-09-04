import Foundation
import ObjectMapper

class ResponseObject<T: Mappable>: Mappable {

	var errorCode: Int!
	var message: String!
	var data: T!
	
	static func newInstance(map: Map) -> Mappable? {
		return ResponseObject<T>()
	}
	
	func mapping(map: Map) {
		errorCode <- map["error_code"]
		message <- map["message"]
		data <- map["data"]
	}

}

