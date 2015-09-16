import Foundation

class TermsOfServiceViewController: UIViewController {
    @IBOutlet weak var eulaTextView: UITextView! {
        didSet {
            let text = NSAttributedString(string: "TERMS_OF_SERVICE_EULA".localized, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(16)])
            self.eulaTextView.attributedText = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TERMS_OF_SERVICE_TITLE".localized
    }
}
