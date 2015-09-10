import Foundation
import Crashlytics

class Analytics {
	
}

extension Analytics {
	
	class func logPlateSearch(carPlate: String) {
		Answers.logSearchWithQuery(carPlate, customAttributes:nil)
	}
	
	class func logFacebookLogin() {
		Answers.logLoginWithMethod("Facebook",
			success: true,
			customAttributes: nil)
	}
	
	class func logSignUp() {
		Answers.logSignUpWithMethod("Digits",
			success: true,
			customAttributes: nil)
	}
}

extension Analytics {
	
	class func logPostCreated(carPlate: String) {
		Answers.logCustomEventWithName("Create post", customAttributes: ["plate": carPlate])
	}
	
	class func logPostFlagged(postId: String) {
		Answers.logCustomEventWithName("Post flagged", customAttributes: ["id": postId])
	}
	
}

extension Analytics {
	
	class func logCreatePostOpened(carPlate: String) {
		Answers.logContentViewWithName("Screen - Create post", contentType: nil, contentId: nil, customAttributes: nil)
	}
	
	class func logViewAllPlates() {
		Answers.logContentViewWithName("Home view",
			contentType: "Plates",
			contentId: "All",
			customAttributes: nil)
	}
	
	class func logViewPlate(carPlate: String) {
		Answers.logContentViewWithName("Specific Plate View",
			contentType: "Plates",
			contentId: carPlate,
			customAttributes: nil)
	}
	
}