import Foundation
import Alamofire
import Crashlytics

@objc
class GoToPlateViewController {

	var alert: UIAlertController!
    var sendButtonAction: UIAlertAction!
	let searchCallback: String -> Void
	
	init(sentCallback: (String -> Void)) {
		searchCallback = sentCallback
		setup()
	}
    
    let title = "GO_TO_PLATE_TITLE".localized
    let cancel = "GO_TO_PLATE_CANCEL".localized
    let ok = "GO_TO_PLATE_OK".localized
	
	func setup() {
		let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addTextFieldWithConfigurationHandler(textFieldChanged)
		alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.Cancel, handler: nil))
        sendButtonAction = UIAlertAction(title: ok, style: UIAlertActionStyle.Default, handler: sendButtonAction)
		alert.addAction(sendButtonAction)
		self.alert = alert
	}
	
	func textFieldChanged(textField: UITextField!) {
		textField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
		textField.placeholder = "AAA-0000"
	}
	
	func sendButtonAction(alertAction: UIAlertAction!) {
        let plate = (self.alert.textFields![0] as! UITextField).text.uppercaseString
		Analytics.logPlateSearch(plate)
		searchCallback(plate)
	}
}