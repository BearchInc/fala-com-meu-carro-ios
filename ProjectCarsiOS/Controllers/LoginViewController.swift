import Foundation
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
	
	override func viewDidLoad() {
		let loginButton = FBSDKLoginButton()
		loginButton.delegate = self
		loginButton.center = self.view.center
		self.view.addSubview(loginButton)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		performSegueWithIdentifier("OCars", sender: self)
	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
		
		if !result.isCancelled {
//			performSegueWithIdentifier("HomeViewControllerOCars", sender: self)
		}
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		
	}
	
	
	
}
