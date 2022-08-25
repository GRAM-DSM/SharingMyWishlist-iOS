import Foundation

// MARK: - ListDataModelElement
struct ListDataModelElement: Codable {
    let id, listDataModelID: Int
    let title, contents, writer: String
    let clear: Bool
    let color: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case listDataModelID = "id"
        case title, contents, writer, clear, color, comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let nickName, comment: String
    let wishList: Int
}

typealias ListDataModel = [ListDataModelElement]

//MARK: - listForm

struct listForm {
    var title, content, writer, color: String
    var clear: Bool
    var id: Int
    
    init(title: String, content: String, writer: String, color: String, clear: Bool, id: Int) {
        self.title = title
        self.content = content
        self.writer = writer
        self.color = color
        self.clear = clear
        self.id = id
    }
}
