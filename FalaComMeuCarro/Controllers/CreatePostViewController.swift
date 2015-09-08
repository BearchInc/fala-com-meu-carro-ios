import Foundation
import UIKit
import NSStringMask
import SwiftEventBus

class CreatePostViewController: UIViewController {
	
	@IBOutlet weak var carplateTextField: UITextFieldMask!
	@IBOutlet weak var messageTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		carplateTextField.mask = NSStringMask(pattern: "([A-Z]{3})-([0-9]{4})")
	}
	
	@IBAction func createPostButtonTouched(sender: AnyObject) {
		
		let plate = carplateTextField.text
		let message = messageTextView.text

		let userId = FBSDKProfile.currentProfile().userID
		let userName = FBSDKProfile.currentProfile().name
		
		Post.createPost(plate, message: message, userId: userId, userName: userName) { (post) in
			self.navigationController?.popViewControllerAnimated(true)
			SwiftEventBus.post("postCreated", sender: post)
		}
	}
}