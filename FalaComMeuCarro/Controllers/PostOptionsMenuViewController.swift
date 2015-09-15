import Foundation

class PostOptionsMenuViewController {
    
    let post: Post
    let reportCallback: Post -> Void
    var alert: UIAlertController!
    
    let cancel = "HOME_ACTION_SHEET_CANCEL".localized
    let inappropriate = "HOME_ACTION_SHEET_INAPPROPRIATE".localized
	let sentBy = "HOME_ACTION_SHEET_SENT_BY".localized
    
    init(post: Post, reportCallback: (Post -> Void)) {
        self.post = post
        self.reportCallback = reportCallback
        setup()
    }
    
    private func setup() {
		
        alert = UIAlertController(title: "\(sentBy) \(post.userName)", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: inappropriate, style: UIAlertActionStyle.Destructive, handler: inapropriateTapped))
    }
    
    private func inapropriateTapped(action: UIAlertAction!) {
        reportCallback(post)
    }
    
    
}