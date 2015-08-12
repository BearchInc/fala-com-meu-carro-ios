import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Post: Mappable {
	
	var carPlate: String!
	var message: String!
	
	class func newInstance(map: Map) -> Mappable? {
		return Post()
	}
	
	func mapping(map: Map) {
		carPlate <- map["car_plate"]
		message <- map["message"]
	}
	
	class func getAllPosts(callback: [Post] -> Void) {
		Alamofire.request(Router.ListAllPosts())
			.responseArray { (response: [Post]?, error: NSError?) in
				if error != nil {
					println("Error in getAllPosts -> \(error)")
					callback([])
				} else {
					callback(response!)
				}
		}

	}
}
