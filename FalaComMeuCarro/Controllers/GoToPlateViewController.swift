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
		let alert = UIAlertController(title: "Ver placa", message: "Qual a placa?", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addTextFieldWithConfigurationHandler(textFieldChanged)
		alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Ir", style: UIAlertActionStyle.Default, handler: sendButtonAction))
		
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