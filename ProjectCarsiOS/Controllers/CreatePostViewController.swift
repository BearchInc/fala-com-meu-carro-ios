import Foundation
import UIKit

class CreatePostViewController: UIViewController {
	
	@IBOutlet weak var carplateTextField: UITextField!
	@IBOutlet weak var messageTextView: UITextView!
	
	
	@IBAction func createPostButtonTouched(sender: AnyObject) {
		
		let plate = carplateTextField.text
		let message = messageTextView.text
		
		Post.createPost(plate, message: message) { (post) in
			println("Successfully sent \(post)")
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
}