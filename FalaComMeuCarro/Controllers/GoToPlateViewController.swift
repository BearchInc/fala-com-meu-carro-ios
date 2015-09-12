import Foundation
import Alamofire
import NSStringMask
import Crashlytics

@objc
class GoToPlateViewController {
	
	let sendButtonIndex = 1
	
	var alert: UIAlertController!
	var feedBackSent: String -> Void
	
	init(sentCallback: (String -> Void)) {
		self.feedBackSent = sentCallback
		setup()
	}
	
	func setup() {
        let title = NSLocalizedString("GO_TO_PLATE_TITLE", comment: "")
        let message = NSLocalizedString("GO_TO_PLATE_MESSAGE", comment: "")
        let cancel = NSLocalizedString("GO_TO_PLATE_CANCEL", comment: "")
        let ok = NSLocalizedString("GO_TO_PLATE_OK", comment: "")
        
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addTextFieldWithConfigurationHandler(textFieldChanged)
		alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.Cancel, handler: nil))
		alert.addAction(UIAlertAction(title: ok, style: UIAlertActionStyle.Default, handler: sendButtonAction))
		
		(alert.actions[sendButtonIndex] as! UIAlertAction).enabled = false
		
		self.alert = alert
	}
	
	func textFieldChanged(textField: UITextField!) {
		textField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
		textField.placeholder = "AAA-0000"
		textField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
	}
	
	func textChanged(textField: UITextField) {
		textField.text = NSStringMask.maskString(textField.text, withPattern: "([A-Z]{3})-([0-9]{4})")
		let enabled = textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 8
		(alert.actions[sendButtonIndex] as! UIAlertAction).enabled = enabled
	}
	
	func sendButtonAction(alertAction: UIAlertAction!) {
        let plate = (self.alert.textFields![0] as! UITextField).text
		Analytics.logPlateSearch(plate)
		feedBackSent(plate)
	}
}