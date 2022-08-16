
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }


}

