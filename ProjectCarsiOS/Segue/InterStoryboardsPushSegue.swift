import Foundation
import UIKit

class InterStoryboardsPushSegue: InterStoryboardsSegue {
	
	override func perform() {
		let source = self.sourceViewController as! UIViewController
		let destination = self.destinationViewController as! UIViewController
		source.navigationController?.pushViewController(destination, animated: true)
	}
	
}
