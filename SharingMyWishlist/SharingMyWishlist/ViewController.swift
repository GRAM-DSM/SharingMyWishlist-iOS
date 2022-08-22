
import UIKit
import SnapKit
import Then
//
class ViewController: UIViewController {
    let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(touchLoginButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
    }
    override func viewWillLayoutSubviews() {
        setUp()
    }
    private func setUp(){
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    @objc private func touchLoginButton(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

