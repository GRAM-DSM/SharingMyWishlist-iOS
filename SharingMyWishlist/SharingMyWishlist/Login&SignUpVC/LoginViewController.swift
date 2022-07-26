
import SnapKit
import UIKit
import Then


class LoginViewController : UIViewController {
    private var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "GRAM Logo-Bright 2")
        $0.contentMode = .scaleToFill
    }
    private var idTextField = UITextField().then {
        $0.placeholder = "아이디를 입력하세요."
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1).cgColor
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1).cgColor
    }
    private let loginButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.layer.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1).cgColor
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    private let signupButton = UIButton(type: .system).then {
        $0.setTitle("아직 계정이 없으세요?", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        targets()
    }
    override func viewWillLayoutSubviews() {
        setUp()
    }
    private func targets(){
        loginButton.addTarget(self, action: #selector(touchLoginButton), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(touchSignUpButton), for: .touchUpInside)
    }
    @objc func touchLoginButton(){
        guard let userId = idTextField.text, userId.isEmpty == false else { return }
        guard let userPw = passwordTextField.text, userPw.isEmpty == false else { return }
    
        MY.request(.signIn(userID: userId, password: userPw)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(LoginDataModel.self, from: result.data) {
                        Token.accessToken = data.accessToken
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                    } else {
                        print("Login: decoder error")
                    }
                default:
                    print("Login: status \(result.statusCode)")
                }
            case .failure(let err):
                print("Login respons fail: \(err.localizedDescription)")
            }
        }
    }
    @objc func touchSignUpButton(){
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    private func setUp(){
        view.backgroundColor = .white
        [logoImageView,idTextField,passwordTextField,loginButton,signupButton]
            .forEach { view.addSubview($0) }

        logoImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(125)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(59.86)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.width.equalTo(164)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
    }
    private func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion:nil)
    }
}
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
