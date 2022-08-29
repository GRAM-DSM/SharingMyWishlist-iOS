import UIKit
import Then
import SnapKit

class ListDetailViewController: UIViewController {

    var listData: listForm?
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 50)
        $0.numberOfLines = .max
    }
    
    private let writerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.textColor = UIColor.gray
        
    }
    
    private let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.numberOfLines = .max
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        view.backgroundColor = .white
        listSetting()
    }
    
    private func listSetting() {
        [titleLabel, writerLabel, contentLabel].forEach( {view.addSubview($0)} )
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.topMargin.equalTo(40)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        if let listData = listData {
            titleLabel.text = listData.title
            writerLabel.text = listData.writer
            contentLabel.text = listData.content
        } else {
            print("error")
        }
    }

}
