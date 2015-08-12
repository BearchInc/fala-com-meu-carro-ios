import Foundation
import UIKit

class PostCell: UITableViewCell {
	
	@IBOutlet weak var licencePlateLabel: UILabel!
	
	@IBOutlet weak var messageLabel: UILabel!
	
	func render(post: Post) {
		licencePlateLabel.text = post.carPlate
		messageLabel.text = post.message
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(false, animated: animated)
	}
}