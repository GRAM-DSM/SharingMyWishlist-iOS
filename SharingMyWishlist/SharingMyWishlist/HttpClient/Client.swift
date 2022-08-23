import Foundation
import Moya

let MY = MoyaProvider<listService>()

enum listService {
    case signIn(userID: String, password: String)
    case signUp(userID: String, password: String, nickname: String)
    case listCreate(title: String, contents: String, color: String)
    case listDelete(listID: String)
    case listInfo(listID: String)
    case listAll
    case listComment(listID: String, comment: String)
}

extension listService: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.209.22.117:8087")!
    }

    var path: String {
        switch self {

        case .signIn:
            return "/auth/signin"
        case .signUp:
            return "/auth/signup"
        case .listCreate:
            return "/wish/create"
        case .listDelete(let listID):
            return "wish/delete/\(listID)"
        case .listInfo(let listID):
            return "wish/\(listID)"
        case .listAll:
            return "wish/all"
        case .listComment(let listID, _):
            return "wish/comment/\(listID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .listInfo, .listCreate, .listDelete, .listAll, .listComment:
            return .post
        }
    }

    var task: Task {
        switch self {

        case .signIn(let userID, let password):
            return .requestJSONEncodable(["userId":"\(userID)", "password":"\(password)"])
        case .signUp(let userID, let password, let nickname):
            return .requestJSONEncodable(["userId":"\(userID)", "password":"\(password)", "nickName":"\(nickname)"])
        case .listCreate(let title, let contents, let color):
            return .requestJSONEncodable(["title":"\(title)", "contents":"\(contents)", "color":"\(color)"])
        case .listComment(_ , let comment):
            return .requestJSONEncodable(["comment":"\(comment)"])
        case .listDelete, .listInfo, .listAll:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {

        case .signIn, .signUp, .listDelete, .listInfo, .listAll:
            return Header.tokenIsEmpty.header()
        case .listCreate, .listComment:
            return Header.accessToken.header()
        }
    }
}
    
    
