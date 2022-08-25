
import UIKit
import SnapKit
import Then

var listData = [listForm]()

class MainViewController: UIViewController {
    
    //MARK: - Items
    
    let listTableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    let addListButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "plus.app")
        $0.action = #selector(addListButtonClick)
    }
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = UITableView.automaticDimension
        addListButton.target = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getListData()
        listTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        setUp()
    }
    private func setUp(){
        [listTableView].forEach( {view.addSubview($0)} )
        view.backgroundColor = .white
        
        listTableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        navigationItem.title = "Wishes"
        navigationItem.rightBarButtonItem = self.addListButton
    }
    
    //MARK: - Setting

    private func getListData() {
        MY.request(.listAll) { res in
            switch res {
            case .success(let result):
                switch result.statusCode{
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ListDataModel.self, from: result.data) {
                        listData = data.map {
                            let title = $0.title
                            let content = $0.contents
                            let writer = $0.writer
                            let color = $0.color
                            let clear = $0.clear
                            let id = $0.id
                            
                            return listForm(title: title, content: content, writer: writer, color: color, clear: clear, id: id)
                        }
                        DispatchQueue.main.async {
                            self.listTableView.reloadData()
                        }
                    } else {
                        print("error")
                    }
                case 403:
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                default:
                    print("err (\(result.statusCode))")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    //MARK: - ClickEventFunction

    @objc func addListButtonClick() {
        self.navigationController?.pushViewController(AddListViewController(), animated: true)
    }
}

//MARK: - extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        
        cell.titleLabel.text = "\(listData[indexPath.row].title)"
        cell.contentLabel.text = "\(listData[indexPath.row].content)"
        cell.userLabel.text = "\(listData[indexPath.row].writer)"
        cell.listColor = listData[indexPath.row].color
        cell.clearBool = listData[indexPath.row].clear
        cell.listID = listData[indexPath.row].id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

