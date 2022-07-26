import UIKit
import Then
import SnapKit

class AddListViewController: UIViewController {
    
    var seletListColor: String = "wish-nor"
    
    //MARK: - Items
    
    //UIbarButtonItems
    private let okButton = UIBarButtonItem().then {
        $0.title = "완료"
        $0.action = #selector(okButtonClick)
    }
    
    private let cancelButton = UIBarButtonItem().then {
        $0.title = "취소"
        $0.tintColor = UIColor.red
        $0.action = #selector(cancelButtonClick)
    }
    
    //Labels
    private let titleLabel = UILabel().then {
        $0.text = "Title"
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "Content"
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    //TextLabel & TextView
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력하세요"
        $0.backgroundColor = UIColor(named: "wish-nor")
        $0.borderStyle = .roundedRect
    }
    
    private let contentTextView = UITextView().then {
        $0.layer.cornerRadius = 10
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.layer.borderWidth = 0.6
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = UIColor(named: "wish-nor")
    }
    
    //colorButtons
    private let whiteColorButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "layer-white")?.cgColor
        $0.backgroundColor = UIColor(named: "wish-nor")
        $0.layer.cornerRadius = 8
        $0.tag = 1
    }
    private let redColorButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "layer-white")?.cgColor
        $0.backgroundColor = UIColor(named: "wish-red")
        $0.layer.cornerRadius = 8
        $0.tag = 2
    }
    private let greenColorButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "layer-white")?.cgColor
        $0.backgroundColor = UIColor(named: "wish-gre")
        $0.layer.cornerRadius = 8
        $0.tag = 3
    }
    private let blueColorButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "layer-white")?.cgColor
        $0.backgroundColor = UIColor(named: "wish-blu")
        $0.layer.cornerRadius = 8
        $0.tag = 4
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        target()
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
    }
    override func viewWillLayoutSubviews() {
        addListSetting()
    }

    private func target() {
        whiteColorButton.addTarget(self, action: #selector(selectColorButton(_:)), for: .touchUpInside)
        redColorButton.addTarget(self, action: #selector(selectColorButton(_:)), for: .touchUpInside)
        blueColorButton.addTarget(self, action: #selector(selectColorButton(_:)), for: .touchUpInside)
        greenColorButton.addTarget(self, action: #selector(selectColorButton(_:)), for: .touchUpInside)
        
        okButton.target = self
        cancelButton.target = self
    }

    //MARK: - Setting
    private func addListSetting() {
        
        [titleLabel, contentLabel, titleTextField, contentTextView,
         whiteColorButton, redColorButton, greenColorButton, blueColorButton].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualToSuperview().inset(100)
            $0.left.equalToSuperview().inset(20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(25)
            $0.left.equalTo(titleTextField.snp.left)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(whiteColorButton.snp.top).inset(-50)
        }
        
        whiteColorButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(4).inset(2)
            $0.left.equalToSuperview().inset(8)
            $0.bottom.equalTo(self.view.snp.bottom).inset(50)
        }
        
        redColorButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(4).inset(2)
            $0.left.equalTo(whiteColorButton.snp.right)
            $0.bottom.equalTo(whiteColorButton.snp.bottom)
        }
        
        blueColorButton.snp.makeConstraints() {
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(4).inset(2)
            $0.left.equalTo(redColorButton.snp.right)
            $0.bottom.equalTo(whiteColorButton.snp.bottom)
        }
        
        greenColorButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(4).inset(2)
            $0.left.equalTo(blueColorButton.snp.right)
            $0.bottom.equalTo(whiteColorButton.snp.bottom)
        }
    }

    private func setNavigation() {
        view.backgroundColor = .white
        navigationItem.title = "Add"
        navigationItem.rightBarButtonItem = okButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    //MARK: - ButtonLayerFunction

    @objc func selectColorButton(_ sender: UIButton) {
        [whiteColorButton, redColorButton, blueColorButton, greenColorButton].forEach({
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
        })
        var layerColor: String = ""
        switch sender.tag {
        case 1:
            layerColor = "layer-white"
            seletListColor = "wish-nor"
        case 2:
            layerColor = "layer-red"
            seletListColor = "wish-red"
        case 3:
            layerColor = "layer-green"
            seletListColor = "wish-gre"
        case 4:
            layerColor = "layer-blue"
            seletListColor = "wish-blu"
        default:
            layerColor = ""
        }

        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor(named: layerColor)?.cgColor
    }
    
    //MARK: - ClickEventFunction

    @objc func okButtonClick() {
        guard let title = titleTextField.text, title.isEmpty == false else { return }
        let content = contentTextView.text ?? ""
        MY.request(.listCreate(title: title, contents: content, color: seletListColor)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    self.navigationController?.popViewController(animated: true)
                case 403:
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                default:
                    print("Create: status err (\(result.statusCode))")
                }
            case .failure(let err):
                print("Create respons fail: \(err.localizedDescription)")
            }
        }
    }
    
    @objc func cancelButtonClick() {
        navigationController?.popViewController(animated: true)
    }
}
