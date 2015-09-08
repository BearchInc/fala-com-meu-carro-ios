import Foundation
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
	
	@IBOutlet weak var loginButton: FBSDKLoginButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupFacebookButton()
	}

	private func goToHomeViewController() {
        performSegue(LoginViewController.Segue.Cars)
	}
	
	private func setupFacebookButton() {
		loginButton.readPermissions = ["public_profile", "email"]
		loginButton.delegate = self
	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
		if !result.isCancelled {
			
			FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name"]).startWithCompletionHandler() {
				(connection, result, error) in
				let profile = FBSDKProfile(userID: result["id"] as! String, firstName: nil, middleName: nil, lastName: nil, name: result["name"] as! String, linkURL: nil, refreshDate: nil)
				FBSDKProfile.setCurrentProfile(profile)
			}
			
			goToHomeViewController()
		} else {
			UIAlertView(title: "Hey", message: "We need you to login, do it please", delegate: nil, cancelButtonTitle: "ok").show()
		}
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		print("")
	}
	
}
