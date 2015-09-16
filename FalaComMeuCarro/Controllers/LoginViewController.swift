import Foundation
import UIKit
import Crashlytics

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
	
	@IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            self.welcomeLabel.text = "LOGIN_WELCOME".localized
        }
    }
    
    @IBOutlet weak var letsLoginLabel: UILabel! {
        didSet {
            self.letsLoginLabel.text = "LOGIN_LETS_GET_STARTED".localized
        }
    }
    
    @IBOutlet weak var weWillNeverPostLabel: UILabel! {
        didSet {
            self.weWillNeverPostLabel.text = "LOGIN_WILL_NEVER_POST".localized
        }
    }
    
    @IBOutlet weak var termsAndConditionsButton: UIButton! {
        didSet {
            self.termsAndConditionsButton.setTitle("LOGIN_TERMS_AND_CONDITIONS_BUTTON".localized, forState: UIControlState.Normal)
        }
    }
    
    let weNeedYouToLogin = "LOGIN_WE_NEED_YOU_TO_LOGIN".localized
    let somethingHappend = "LOGIN_SOMETHING_HAPPENED_TRY_AGAIN".localized
    let tryAgain = "LOGIN_TRY_AGAIN".localized
    let oops = "LOGIN_OOPS".localized
    
    let facebookFields = "id,first_name,last_name,middle_name,name,link,updated_time,email"
	
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
			showAlertController(weNeedYouToLogin,
				action: UIAlertAction(title: "Ok",
				style: UIAlertActionStyle.Cancel, handler: nil))
		}
	}
    
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
		println("Estamos tristes de te ver partir :(")
	}
    
    
	
	private func fetchUserProfile() {
		FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : facebookFields]).startWithCompletionHandler() {
			(connection, result, error) in
			
			if error != nil {
				self.showAlertController(self.somethingHappend, action: UIAlertAction(title: self.tryAgain, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
					self.fetchUserProfile()
				}))
				return
			}
			
            FacebookProfile(result: result as! NSDictionary).save()
            
			self.goToHomeViewController()
		}
	}
	
	private func showAlertController(message: String, action: UIAlertAction) {
		let alertController = UIAlertController(title: oops, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(action)
		presentViewController(alertController, animated: true, completion: nil)
	}
	
}
