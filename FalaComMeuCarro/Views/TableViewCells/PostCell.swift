import Foundation
import UIKit
import SwiftDate

class PostCell: UITableViewCell {
	
	@IBOutlet weak var licencePlateLabel: UIButton!
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var authorAndDate: UILabel!
	
	var plateButtonCallback: (String -> Void)?
	
	func render(post: Post) {
		licencePlateLabel.setTitle(post.carPlate, forState: UIControlState.Normal)
		messageLabel.text = post.message
		messageLabel.preferredMaxLayoutWidth = self.messageLabel.bounds.width
		
		let relativeString = post.createdAt.toRelativeString(fromDate: NSDate(), abbreviated: true, maxUnits: 1)
		authorAndDate.text = "\(post.userName) - \(relativeString)"
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(false, animated: animated)
	}
	
	
	@IBAction func plateButtonTouched(sender: AnyObject) {
		if plateButtonCallback != nil {
			plateButtonCallback!(licencePlateLabel.titleLabel!.text!)
		}
	}
	
}