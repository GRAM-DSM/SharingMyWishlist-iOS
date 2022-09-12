import Foundation

struct ListDataModel: Codable {
    let wishResponseList: [ListDataModelElement]
}

//MARK: - listForm
struct listForm {
    var title, contents, writer, color, createdAt: String
    var clear: Bool
    var id: Int
    init(title: String, contents: String, writer: String, color: String, clear: Bool, id: Int, createdAt: String) {
        self.title = title
        self.contents = contents
        self.writer = writer
        self.color = color
        self.clear = clear
        self.id = id
        self.createdAt = createdAt
    }
}
