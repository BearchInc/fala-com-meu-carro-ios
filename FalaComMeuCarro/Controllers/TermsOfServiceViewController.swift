import Foundation

class TermsOfServiceViewController: UIViewController {
    @IBOutlet weak var eulaTextView: UITextView! {
        didSet {
            self.eulaTextView.text = NSLocalizedString("TERMS_OF_SERVICE_EULA", comment: "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("TERMS_OF_SERVICE_TITLE", comment: "")
    }
}
