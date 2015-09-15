import Foundation
import UIKit
import DateTools

class PostCell: UITableViewCell {
	
	@IBOutlet weak var licencePlateLabel: UIButton!
	@IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
	var plateButtonCallback: (String -> Void)?
    var optionsCallback: (Post! -> Void)!
    
    var post: Post!
	
	func render(post: Post) {
        self.post = post
		licencePlateLabel.setTitle(post.carPlate, forState: UIControlState.Normal)
		messageLabel.text = post.message
		messageLabel.preferredMaxLayoutWidth = self.messageLabel.bounds.width
        dateLabel.text = post.createdAt.timeAgoSinceNow()
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(false, animated: animated)
	}
	
	
	@IBAction func plateButtonTouched(sender: AnyObject) {
		if plateButtonCallback != nil {
			plateButtonCallback!(licencePlateLabel.titleLabel!.text!)
		}
	}
	
    @IBAction func optionsButtonTouched(sender: AnyObject) {
        optionsCallback(post!)
    }
}