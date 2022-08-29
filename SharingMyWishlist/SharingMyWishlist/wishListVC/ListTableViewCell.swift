import UIKit
import Then
import SnapKit

class ListTableViewCell: UITableViewCell {
    
    var listID: Int = .init()
    var listColor: String = ""
    var clearBool: Bool = false
    
    //MARK: - Items
    
    //Labels
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    let contentLabel = UILabel().then {
        $0.text = "content"
        $0.numberOfLines = 4
    }
    
    let userLabel = UILabel().then {
        $0.text = "user"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .darkGray
    }
    
    //view
    private let backView = UIView().then {
        $0.layer.cornerRadius = 4
    }
    
    //Button
    private let clearButton = UIButton(type: .system).then {
        $0.tintColor = UIColor.gray
        $0.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .regular), forImageIn: .normal)
    }
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        cellStting()
        targetSetting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setting
    
    private func cellStting() {
        clearButton.setImage(UIImage(systemName: "checkmark.square\(clearBool ? ".fill" : "")"), for: .normal)
        self.addSubview(backView)
        backView.backgroundColor = UIColor(named: "\(listColor)")
        [titleLabel, userLabel, contentLabel, clearButton].forEach( {backView.addSubview($0)} )
        
        titleLabel.snp.makeConstraints {
            $0.topMargin.equalTo(5)
            $0.left.equalTo(backView.snp.left).inset(15)
            $0.right.lessThanOrEqualTo(backView.snp.right).inset(80)
        }
        
        userLabel.snp.makeConstraints {
            $0.left.lessThanOrEqualTo(titleLabel.snp.right).offset(10)
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.right.lessThanOrEqualTo(backView.snp.right).inset(15)
        }
        
        contentLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.right.equalTo(clearButton.snp.left).offset(-20)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(backView.snp.centerY)
            $0.right.equalTo(backView.snp.right).inset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(35)
        }
        
        backView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).inset(10)
            $0.right.equalTo(self.snp.right).inset(10)
            $0.height.equalTo(120)
        }

    }
    
    private func targetSetting() {
        clearButton.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
    }
    
    //ClickEventFunction
    @objc func clearButtonClick() {
        MY.request(.listPatchClear(listID: listID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    self.clearBool.toggle()
                    DispatchQueue.main.async {
                        self.clearButton.setImage(UIImage(systemName: "checkmark.square\(self.clearBool ? ".fill" : "")"), for: .normal)
                    }
                case 403:
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    MainViewController().present(vc, animated: true)
                default:
                    print("Clear: error")
                }
            case .failure(let err):
                print("Clear respons fail: \(err.localizedDescription)")
            }
        }
    }
    
}
