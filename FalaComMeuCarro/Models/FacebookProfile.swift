import Foundation

class FacebookProfile {
    var email: String
    var facebookProfile: FBSDKProfile
    
    init(result: NSDictionary) {
        facebookProfile = FBSDKProfile(userID: result["id"] as! String,
            firstName: result["first_name"] as! String,
            middleName: result["middle_name"] as? String,
            lastName: result["last_name"] as! String,
            name: result["name"] as! String,
            linkURL: NSURL(string: result["link"] as! String),
            refreshDate: nil) // result["updated_time"] as! NSDate
        email = result["email"] as! String
    }
    
    init(email: String, facebookProfile: FBSDKProfile) {
        self.email = email
        self.facebookProfile = facebookProfile
    }
    
    func save() {
        FBSDKProfile.setCurrentProfile(facebookProfile)
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "user_email")
    }
    
    class func retrieve() -> FacebookProfile {
        let email = NSUserDefaults.standardUserDefaults().objectForKey("user_email") as! String
        let facebookProfile = FBSDKProfile.currentProfile()
        let profile = FacebookProfile(email: email, facebookProfile: facebookProfile)
        return profile
    }
}