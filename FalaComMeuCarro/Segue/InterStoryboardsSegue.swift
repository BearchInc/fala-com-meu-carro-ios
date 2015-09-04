import Foundation
import UIKit

class InterStoryboardsSegue: UIStoryboardSegue {
	
	override init!(identifier: String?, source: UIViewController, destination: UIViewController) {
		let destinationViewController = InterStoryboardsPresentSegue.sceneNamed(identifier!)
		super.init(identifier: identifier, source: source, destination: destinationViewController)
	}
	
	class func sceneNamed(identifier: String) -> UIViewController {
		let components = identifier.componentsSeparatedByString("_")
		let storyboardName = components[1]
		let sceneName = components[0]
		
		let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
		
		if sceneName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
			return storyBoard.instantiateInitialViewController() as! UIViewController
		} else {
			return storyBoard.instantiateViewControllerWithIdentifier(sceneName) as! UIViewController
		}
	}
	
	override func perform() {
		exit(1)
	}
	
}
