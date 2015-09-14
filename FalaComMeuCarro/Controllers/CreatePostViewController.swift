import Foundation
import UIKit
import SwiftEventBus

class CreatePostViewController: UIViewController {
	
    @IBOutlet weak var carplateLabel: UILabel! {
        didSet {
            self.carplateLabel.text = "CREATE_POST_CAR_PLATE_LABEL".localized
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            self.messageLabel.text = "CREATE_POST_MESSAGE_LABEL".localized
        }
    }
    
	@IBOutlet weak var carplateTextField: UITextView!
	@IBOutlet weak var messageTextView: UITextView!
    
    let createPostTitle = "CREATE_POST_TITLE".localized
    let send = "CREATE_POST_SEND_BUTTON".localized
    let plateInvalid = "CREATE_POST_INVALID_PLATE".localized
    let messsageEmpty = "CREATE_POST_MESSAGE_CANNOT_BE_EMPTY".localized
    let oops = "CREATE_POST_OOPS".localized
	
	override func viewDidLoad() {
		super.viewDidLoad()
        title = createPostTitle
        navigationItem.rightBarButtonItem?.title = send
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
			showValidationAlert(plateInvalid)
			isValid = false
		} else if messageTextView.text.isEmpty {
			showValidationAlert(messsageEmpty)
			isValid = false
		}
		
		return isValid
	}
	
	private func showValidationAlert(message: String) {
		let alertController = UIAlertController(title: oops, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
		presentViewController(alertController, animated: true, completion: nil)
	}

}