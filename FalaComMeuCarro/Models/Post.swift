import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import Crashlytics

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
			.responseObject { (response: ResponseArray<Post>?, error: NSError?) in
				if error != nil {
					println("Error in getAllPosts -> \(error)")
					callback([])
				} else {
					println("getAllPosts -> \(response!.errorCode); \(response!.message)")
					callback(response!.data)
				}
		}
	}
	
	class func getAllPostsByCarPlate(carPlate: String, callback: [Post] -> Void) {
		Alamofire.request(Router.ListPostByCarPlate(carPlate))
			.responseObject { (response: ResponseArray<Post>?, error: NSError?) in
				if error != nil {
					println("Error in getAllPostsByCarPlate -> \(error)")
					callback([])
				} else {
					Answers.logCustomEventWithName("Get carplate", customAttributes: ["plate": carPlate])
					callback(response!.data)
				}
		}
	}
	
	class func createPost(carPlate: String, message: String, userId: String, userName: String, callback: Post? -> Void) {
		Alamofire.request(Router.CreatePost(carPlate, message, userId, userName))
			.responseObject { (response: ResponseObject<Post>?, error: NSError?) in
				if error != nil {
					println("Error in createPost -> \(error)")
					callback(nil)
				} else {
					Answers.logCustomEventWithName("Create post", customAttributes: ["plate": carPlate])
					callback(response!.data)
				}
		}
	}
}
