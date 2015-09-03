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
			.responseObject { (response: Response<[Post]>?, error: NSError?) in
				if error != nil {
					println("Error in getAllPosts -> \(error)")
					callback([])
				} else {
//					println(response!)
//					println(response!.getData())
					callback(response!.getData())
				}
		}
	}
	
	class func getAllPostsByCarPlate(carPlate: String, callback: [Post] -> Void) {
		Alamofire.request(Router.ListPostByCarPlate(carPlate))
			.responseArray { (response: [Post]?, error: NSError?) in
				if error != nil {
					println("Error in getAllPostsByCarPlate -> \(error)")
					callback([])
				} else {
					callback(response!)
				}
		}
	}
	
	class func createPost(carPlate: String, message: String, callback: Post? -> Void) {
		Alamofire.request(Router.CreatePost(carPlate, message))
			.responseObject { (response: Post?, error: NSError?) in
				if error != nil {
					println("Error in createPost -> \(error)")
					callback(nil)
				} else {
					callback(response!)
				}
		}
	}
}
