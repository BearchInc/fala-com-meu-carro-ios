import Foundation
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if (FBSDKAccessToken.currentAccessToken() != nil) {
			goToHomeViewController()
		} else {
			setupFacebookButton()
		}
	}
	
	private func goToHomeViewController() {
		performSegueWithIdentifier("OCars", sender: self)
	}
	
	private func setupFacebookButton() {
		let loginButton = FBSDKLoginButton()
		loginButton.readPermissions = ["email"]
		loginButton.delegate = self
		loginButton.center = self.view.center
		
		self.view.addSubview(loginButton)
	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
		
		if !result.isCancelled {
			goToHomeViewController()
//			performSegueWithIdentifier("HomeViewControllerOCars", sender: self)
		} else {
			UIAlertView(title: "Hey", message: "We need you to login, do it please", delegate: nil, cancelButtonTitle: "ok").show()
		}
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		print("")
	}
	
}
