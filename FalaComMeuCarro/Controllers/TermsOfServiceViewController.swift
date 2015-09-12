import Foundation

class TermsOfServiceViewController: UIViewController {
    @IBOutlet weak var eulaTextView: UITextView! {
        didSet {
            self.eulaTextView.text = "TERMS_OF_SERVICE_EULA".localized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TERMS_OF_SERVICE_TITLE".localized
    }
}
