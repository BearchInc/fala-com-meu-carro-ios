import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Post: Mappable {
	
    var postId: String!
	var carPlate: String!
	var message: String!
	var userName: String!
	var createdAt: NSDate!
	
	class func newInstance(map: Map) -> Mappable? {
		return Post()
	}
	
	func mapping(map: Map) {
		carPlate <- map["car_plate"]
		message <- map["message"]
		userName <- map["user_name"]
		createdAt <- (map["created_at"], DateTransform())
        postId <- map["id"]
	}
	
	class func getAllPosts(callback: [Post] -> Void) {
		Alamofire.request(Router.ListAllPosts())
			.responseObject { (response: ResponseArray<Post>?, error: NSError?) in
				if error != nil {
					println("Error in getAllPosts -> \(error)")
					callback([])
				} else {
					Analytics.logViewAllPlates()
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
					Analytics.logViewPlate(carPlate)
					callback(response!.data)
				}
		}
	}
	
    class func createPost(carPlate: String, message: String, userId: String, userName: String, email: String, callback: Post? -> Void) {
		Alamofire.request(Router.CreatePost(carPlate, message, userId, userName, email))
			.responseObject { (response: ResponseObject<Post>?, error: NSError?) in
				if error != nil {
					println("Error in createPost -> \(error)")
					callback(nil)
				} else {
					Analytics.logPostCreated(carPlate)
					callback(response!.data)
				}
		}
	}

    class func flagPost(post: Post, callback: (post: Post?) -> Void) {
        Alamofire.request(Router.FlagPost(postId: post.postId))
            .responseObject { (response: ResponseObject<Post>?, error: NSError?) in
                if error != nil {
                    println("Error in createPost -> \(error)")
                    callback(post: nil)
                } else {
					Analytics.logPostFlagged(post.postId)
                    callback(post: response!.data)
                }
        }
    }
}
