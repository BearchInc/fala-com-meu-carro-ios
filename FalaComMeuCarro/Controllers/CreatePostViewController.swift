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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        carplateTextField.becomeFirstResponder()
    }
	
	@IBAction func createPostButtonTouched(sender: AnyObject) {
		
		let plate = carplateTextField.text
		let message = messageTextView.text

        let profile = FacebookProfile.retrieve()
        let facebookProfile = profile.facebookProfile
		let userId = facebookProfile.userID
		let lastName = facebookProfile.lastName
		
		let userName = "\(facebookProfile.firstName) \(lastName[lastName.startIndex])."
		
		if isPostValid() {
            Post.createPost(plate, message: message, userId: userId, userName: userName, email: profile.email) { (post) in
				self.navigationController?.popViewControllerAnimated(true)
				SwiftEventBus.post("postCreated", sender: post)
			}
		}
	}
	
	private func isPostValid() -> Bool {
		var isValid = true
		if count(carplateTextField.text) != 8 {
			showValidationAlert("Placa inválida")
			isValid = false
		} else if messageTextView.text.isEmpty {
			showValidationAlert("Mensagem não pode ser vazia")
			isValid = false
		}
		
		return isValid
	}
	
	private func showValidationAlert(message: String) {
		let alertController = UIAlertController(title: "Ooops", message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
		presentViewController(alertController, animated: true, completion: nil)
	}

}