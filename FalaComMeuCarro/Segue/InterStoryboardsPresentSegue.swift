import Foundation
import UIKit

class InterStoryboardsPresentSegue: InterStoryboardsSegue {
	
	override func perform() {
		let source = self.sourceViewController as! UIViewController
		let destination = self.destinationViewController as! UIViewController
		source.presentViewController(destination, animated: true, completion: nil)
	}
	
}
