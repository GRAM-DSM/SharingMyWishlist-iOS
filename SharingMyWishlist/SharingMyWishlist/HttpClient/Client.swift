import Foundation
import Moya

let MY = MoyaProvider<listService>()

enum listService {
    case signIn(userID: String, password: String)
    case signUp(userID: String, password: String, nickname: String)
    case listCreate(title: String, contents: String, color: String)
    case listDelete(listID: Int)
    case listInfo(listID: Int)
    case listAll
    case listComment(listID: Int, comment: String)
    case CommentUpRoad(listID: Int, comment: String)
    case listPatchClear(listID: Int)
}

extension listService: TargetType {
    var baseURL: URL {
        return URL(string: "http://192.168.137.164:8087")!
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
            return "/wish/delete/\(listID)"
        case .listInfo(let listID):
            return "/comment/\(listID)"
        case .listAll:
            return "/wish/all"
        case .listComment(let listID, _):
            return "/wish/comment/\(listID)"
        case .CommentUpRoad(let listID, _):
            return "/wish/comment/\(listID)"
        case .listPatchClear(let listID):
            return "/wish/clear/\(listID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .listCreate, .CommentUpRoad:
            return .post
        case .listInfo, .listAll, .listComment:
            return .get
        case .listDelete:
            return .delete
        case .listPatchClear:
            return .patch
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
        case .CommentUpRoad(_ , let comment):
            return .requestJSONEncodable(["comment":"\(comment)"])
        case .listDelete, .listInfo, .listAll, .listPatchClear:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
            
        case .signIn, .signUp:
            return Header.tokenIsEmpty.header()
        case .listCreate, .listComment, .listAll, .listDelete, .listInfo, .listPatchClear, .CommentUpRoad:
            return Header.accessToken.header()
        }
    }
}
    
    
