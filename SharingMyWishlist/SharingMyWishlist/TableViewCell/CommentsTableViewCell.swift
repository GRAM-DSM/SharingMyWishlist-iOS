import UIKit
import Then
import SnapKit

class CommentsTableViewCell: UITableViewCell {
    let userLabel = UILabel().then {
        $0.text = "user"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .darkGray
    }
    let commentsLabel = UILabel().then {
        $0.text = "comments"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.numberOfLines = 3
    }

    //MARK: - LayoutSubviews
    override func layoutSubviews() {
        cellStting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setting
    private func cellStting() {
        [userLabel, commentsLabel].forEach { self.addSubview($0) }
        userLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(50)
            $0.top.equalToSuperview()
        }
        commentsLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(50)
            $0.top.equalTo(userLabel.snp.bottom).offset(10)
        }
        
    }
    
}
