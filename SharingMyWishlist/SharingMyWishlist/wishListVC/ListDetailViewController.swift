import UIKit
import Then
import SnapKit

class ListDetailViewController: UIViewController {
    var listData: listForm?
    var listComments = ListDataAllModel(commentResponseList: [])
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.numberOfLines = .max
    }
    
    private let writerLabel = UILabel().then {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableSetting()
        commentsTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getComments()
    }
    
    override func viewWillLayoutSubviews() {
        view.backgroundColor = .white
        listSetting()
        insertData()
    }
    
    private func tableSetting() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "CommentsTableViewCell")
        commentsTableView.rowHeight = 100
        commentsTableView.estimatedRowHeight = UITableView.automaticDimension
        navigationItem.title = "댓글"
    }
    private func listSetting() {
        

        [titleLabel, writerLabel, contentLabel, commentsTableView].forEach( {view.addSubview($0)} )
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        commentsTableView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
    private func insertData(){
        if let listData = listData {
            titleLabel.text = listData.title
            writerLabel.text = listData.writer
            contentLabel.text = listData.contents
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
                        print(self.listComments.commentResponseList[0].id)
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
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
}
