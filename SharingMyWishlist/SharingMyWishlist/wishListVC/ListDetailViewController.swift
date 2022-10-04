import UIKit
import Then
import SnapKit

class ListDetailViewController: UIViewController {
    var listData: ListForm?
    var listComments = ListDataAllModel(commentResponseList: [])
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.numberOfLines = .max
    }
    
    private let writerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.gray
    }
    private let createdAtLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.gray
    }
    private let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = .max
    }
    private let commentsTableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    private let commentsTextFiled = UITextField().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        $0.addLeftPadding()
    }
    private let commentsUpRoadButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.918, alpha: 1).cgColor
        $0.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        $0.setTitle("작성", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        buttonTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        getComments()
    }
    override func viewWillLayoutSubviews() {
        view.backgroundColor = .white
        listSetting()
        insertData()
    }

    private func setTableView() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "CommentsTableViewCell")
        commentsTableView.rowHeight = 100
        commentsTableView.estimatedRowHeight = UITableView.automaticDimension
        navigationItem.title = "댓글"
    }

    private func buttonTargets() {
        commentsUpRoadButton.addTarget(self, action: #selector(commentsUpRoad), for: .touchUpInside)
    }
    @objc func commentsUpRoad() {
        guard let id = listData?.id else { return }
        guard let comment = commentsTextFiled.text else { return }
        MY.request(.CommentUpRoad(listID: id, comment: comment)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    print("성공")
                    self.commentsTableView.reloadData()
                    self.getComments()
                default:
                    print("list id err")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    private func listSetting() {

        [titleLabel, writerLabel, contentLabel, commentsTableView, commentsTextFiled,commentsUpRoadButton, createdAtLabel]
            .forEach { view.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview().inset(76)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        commentsTableView.snp.makeConstraints {
            $0.top.equalTo(commentsTextFiled.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        commentsTextFiled.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(21)
            $0.left.equalToSuperview().inset(10)
            $0.height.equalTo(44)
            $0.width.greaterThanOrEqualTo(267)
        }
        commentsUpRoadButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(21)
            $0.left.equalTo(commentsTextFiled.snp.right).offset(6)
            $0.height.equalTo(44)
            $0.width.equalTo(82)
            $0.right.equalToSuperview().inset(10)
        }
    }
    private func insertData(){
        if let listData = listData {
            titleLabel.text = listData.title
            writerLabel.text = listData.writer
            contentLabel.text = listData.contents
            createdAtLabel.text = listData.createdAt
        } else {
            print("error")
        }
    }
    private func getComments(){
        guard let id = listData?.id else { return }
        MY.request(.listInfo(listID: id)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ListDataAllModel.self, from: result.data) {
                        
                        self.listComments.commentResponseList = data.commentResponseList
                        self.commentsTableView.reloadData()
                    } else {
                        print("디코드 에러")
                    }
                default:
                    print("list id err")
                }
            case .failure(let err):
                print(err)
            }
        }

    }
}

extension ListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listComments.commentResponseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as? CommentsTableViewCell else { return UITableViewCell() }
        cell.commentsLabel.text = listComments.commentResponseList[indexPath.row].comment
        cell.userLabel.text = listComments.commentResponseList[indexPath.row].nickName
        cell.createdAtLabel.text = listComments.commentResponseList[indexPath.row].createdAt
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
}
