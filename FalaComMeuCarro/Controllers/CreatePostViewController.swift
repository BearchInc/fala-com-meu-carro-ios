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
    
	@IBOutlet weak var carplateTextField: UITextField!
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
		
		let paddingView = UIView(frame: CGRectMake(0, 0, 5, 20))
		carplateTextField.leftView = paddingView;
		carplateTextField.leftViewMode = .Always
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
            Post.createPost(plate, message: message, userId: userId, userName: userName, email: profile.email) { (response, error) in
				if error != nil {
					self.showValidationAlert("CREATE_POST_INTERNET_PROBLEM".localized)
				} else if response!.errorCode != 200 {
					self.showValidationAlert(self.plateInvalid)
				} else {
					self.navigationController?.popViewControllerAnimated(true)
					SwiftEventBus.post("postCreated", sender: response?.data)
				}
			}
		}
	}
	
	private func isPostValid() -> Bool {
		var isValid = true

		if messageTextView.text.isEmpty {
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