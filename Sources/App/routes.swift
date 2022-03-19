import Vapor
import LeafMarkdown
import Ink

enum Tag: String, Encodable {
    case Swift = "Swift"
    case iOS = "iOS"
}

struct IndexData: Encodable {
    let root: String
    let posts: [IndexpostInfo]
}

struct IndexpostInfo: Encodable {
    let title: String
    let context: String
    let date: String
    let tags: [Tag]
}

let postData: [IndexpostInfo] = [
    IndexpostInfo(title: "first post", context: "첫번째 포스트 입니다.", date: "2022-03-19", tags: [.Swift, .iOS]),
    IndexpostInfo(title: "first post", context: "첫번째 포스트 입니다.", date: "2022-03-19", tags: [.Swift, .iOS]),
    IndexpostInfo(title: "first post", context: "첫번째 포스트 입니다.", date: "2022-03-19", tags: [.Swift, .iOS]),
    IndexpostInfo(title: "first post", context: "첫번째 포스트 입니다.", date: "2022-03-19", tags: [.Swift, .iOS])
]

func routes(_ app: Application) throws {
    
    app.get { req in
        return req.view.render("index", IndexData(root: "http://127.0.0.1:8080/", posts: postData))
    }
    
    app.get("posts", ":name") { req -> EventLoopFuture<View> in
        let page = req.parameters.get("name")!
        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/\(page).md")
        let parser = MarkdownParser()
        let result = parser.parse(templateString)
        let dateString = result.metadata["date"]
        let html = result.html
        return req.view.render("post", ["name": html])
    }
}
