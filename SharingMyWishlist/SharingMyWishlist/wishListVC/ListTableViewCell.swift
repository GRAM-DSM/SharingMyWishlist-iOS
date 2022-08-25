import UIKit
import Then
import SnapKit

class ListTableViewCell: UITableViewCell {
    
    var listID: Int = .init()
    var listColor: String = ""
    var clearBool: Bool = false
    
    //MARK: - Items
    
    //Labels
    private let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "content"
        $0.numberOfLines = .max
    }
    
    private let userLabel = UILabel().then {
        $0.text = "user"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .lightGray
    }
    
    //view
    private let backView = UIView().then {
        $0.layer.cornerRadius = 8
    }
    
    //Button
    private let clearButton = UIButton().then {
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
        }
        
        userLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(10)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        contentLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.right.equalTo(clearButton.snp.right).offset(10)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(backView.snp.centerY)
            $0.right.equalTo(backView.snp.right).inset(10)
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
            case .success:
                print("clear success")
            case .failure(let err):
                print(err)
            }
        }
        print("click")
    }

}
