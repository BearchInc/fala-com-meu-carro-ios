import Foundation
import Alamofire

enum Router: URLRequestConvertible {
	static let baseURLString = Config.get(.BaseUrl)
	static var OAuthToken: String?
	
	case CreatePost(String, String, String, String)
	case ListAllPosts()
	case ListPostByCarPlate(String)
	
	var method: Alamofire.Method {
		switch self {
		case .CreatePost:
			return .POST
		case .ListAllPosts:
			return .GET
		case .ListPostByCarPlate:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .CreatePost(let carPlate, let message, let userId, let userName):
			return "/posts/create"
		case .ListAllPosts():
			return "/posts/list"
		case .ListPostByCarPlate(let carplate):
			return "/posts/list/\(carplate)"
		}
	}
	
	// MARK: URLRequestConvertible
	
	var URLRequest: NSURLRequest {
		let URL = NSURL(string: Router.baseURLString)!
		let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
		mutableURLRequest.HTTPMethod = method.rawValue
		
		if let token = Router.OAuthToken {
			mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		
		switch self {
		case .CreatePost(let carPlate, let message, let userId, let userName):
			let parameters = ["car_plate" : carPlate, "message" : message, "user_id" : userId, "user_name" : userName]
			return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
		case .ListAllPosts():
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
		case .ListPostByCarPlate(let carPlate):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
		default:
			return mutableURLRequest
		}
	}
}