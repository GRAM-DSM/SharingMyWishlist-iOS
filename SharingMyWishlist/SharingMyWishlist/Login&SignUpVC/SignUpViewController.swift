import UIKit
import Then
import SnapKit
    
class SignUpViewController: UIViewController {
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "GRAM Logo-Bright 2")
        $0.contentMode = .scaleToFill
    }
    private let nickNameTextField = UITextField().then {
        $0.placeholder = "사용하실 이름을 입력하세요."
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1).cgColor
    }
    private let idTextField = UITextField().then {
        $0.placeholder = "사용하실 아이디를 입력하세요."
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1).cgColor
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "사용하실 비밀번호를 입력하세요."
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1).cgColor
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.layer.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1).cgColor
        $0.setTitle("Sign Up", for: .normal)
        $0.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("이미 계정이 있으세요?", for: .normal)
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
        signUpButton.addTarget(self, action: #selector(touchSignUpButton), for: .touchUpInside)
    }
    @objc func touchLoginButton(){
        self.dismiss(animated: true)
    }
    @objc func touchSignUpButton(){
        guard let nickname = nickNameTextField.text, nickname.isEmpty == false else { return }
        guard let userId = idTextField.text, userId.isEmpty == false else { return }
        guard let userPw = passwordTextField.text, userPw.isEmpty == false else { return }
        
        MY.request(.signUp(userID: userId, password: userPw, nickname: nickname)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    self.alert(title: "안내", message: "회원가입이 완료되었습니다.")
                default:
                    print("SignUp: result error (\(result.statusCode)")
                }
            case .failure(let err):
                print("SignUp respons fail: \(err.localizedDescription)")
            }
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
    private func setUp(){
        view.backgroundColor = .white
        [logoImageView,nickNameTextField,idTextField,passwordTextField,signUpButton,loginButton].forEach { view.addSubview($0)
        }
        logoImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(81)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(59.86)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.width.equalTo(164)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
    }
}
