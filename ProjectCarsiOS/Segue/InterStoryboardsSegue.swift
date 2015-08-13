import Foundation
import UIKit

class InterStoryboardsSegue: UIStoryboardSegue {
	
	override init!(identifier: String?, source: UIViewController, destination: UIViewController) {
		let destinationViewController = InterStoryboardsSegue.sceneNamed(identifier!)
		super.init(identifier: identifier, source: source, destination: destinationViewController)
	}
	
	class func sceneNamed(identifier: String) -> UIViewController {
		
		let components = identifier.componentsSeparatedByString("O")
		let storyboardName = components[1]
		let sceneName = components[0]
		
		let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
		
		var a: UIViewController?
		if sceneName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
			a =  storyBoard.instantiateInitialViewController() as! UIViewController
		} else {
			a =  storyBoard.instantiateViewControllerWithIdentifier(sceneName) as! UIViewController
		}
		
		return a!
	}
	
	override func perform() {
		let source = self.sourceViewController as! UIViewController
		let destination = self.destinationViewController as! UIViewController
		source.navigationController?.pushViewController(destination, animated: true)
	}
	
}
