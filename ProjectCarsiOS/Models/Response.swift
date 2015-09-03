import Foundation
import ObjectMapper

class Response<T>: Mappable {

	var errorCode: Int!
	var message: String!
	private var data: AnyObject!
	
	static func newInstance(map: Map) -> Mappable? {
		return Response<T>()
	}
	
	func mapping(map: Map) {
		errorCode <- map["error_code"]
		message <- map["message"]
		data <- map["data"]
	}
	
	func getData() -> T {
//		if data is NSArray {
////			let a = init(T.self)
////			let a = T()
//			let t = T.self
//			
////			reflect<T>(data)
//			
//			var lelelel = Array<Post>()
//			var classString = NSStringFromClass(lelelel.self.dynamicType)
//
//			var anyobjectype : AnyObject.Type = NSClassFromString(classString)
//			var nsobjectype : NSObject.Type = anyobjectype as! NSObject.Type
//			
//			var array = nsobjectype() as! T as! Array<Post>
//			
////			let
////			let locoMeu = OBJCinitwith
//			
////			let b = T.self as! Array<Post>.self
////			let a = T.self.Element()
//
////			println("\(().Element())")
////			Array<Post>.Element()
//			let dataArray = data as! NSArray
////			let dtype = dataArray[0].dynamicType
//			let value = dataArray[0]
////			var array = Array<Post>()
//			for item in dataArray {
//				array.append(Mapper<Post>().map(item)!)
//			}
//
//			return array as! T
//		} else {
			return data as! T
//		}

	}
	
}

