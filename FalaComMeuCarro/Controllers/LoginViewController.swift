import Foundation
import UIKit
import Crashlytics

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
        if result == nil {
            CLSLogv("Error: %@", getVaList([error]))
            CLSLogv("Result: %@", getVaList([result.description]))
        }
        
    	if !result.isCancelled {
            //Check whether it is first login (aka signup) or if the user is comming back
			Analytics.logSignUp()
			fetchUserProfile()
			
		} else {
			showAlertController("Nós precisamos que você faça login.",
				action: UIAlertAction(title: "Ok",
				style: UIAlertActionStyle.Cancel, handler: nil))
		}
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		println("Estamos tristes de te ver partir :(")
	}
	
	private func fetchUserProfile() {
		FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id,first_name,last_name,middle_name,name,link,updated_time,email" ]).startWithCompletionHandler() {
			(connection, result, error) in
			
			if error != nil {
				self.showAlertController("Algum problema aconteceu, tente de novo por favor :)", action: UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
					self.fetchUserProfile()
				}))
				return
			}
			
            FacebookProfile(result: result as! NSDictionary).save()
            
			self.goToHomeViewController()
		}
	}
	
	private func showAlertController(message: String, action: UIAlertAction) {
		let alertController = UIAlertController(title: "Opa", message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(action)
		presentViewController(alertController, animated: true, completion: nil)
	}
	
}
