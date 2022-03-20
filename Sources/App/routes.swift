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
    let allTags: [Tag]
}

struct IndexpostInfo: Encodable {
    let title: String
    let context: String
    let date: String
    let file: String
    let tags: [Tag]
    let thumb: String
}

let postData: [IndexpostInfo] = [
    IndexpostInfo(title: "Second post", context: "첫번째 포스트 입니다.", date: "2022-03-19", file: "SecondPost", tags: [.Swift, .iOS], thumb: "/images/strongImage.png"),
    IndexpostInfo(title: "Second post", context: "첫번째 포스트 입니다.", date: "2022-03-19", file: "SecondPost", tags: [.Swift, .iOS], thumb: "/images/strongImage.png"),
    IndexpostInfo(title: "Second post", context: "첫번째 포스트 입니다.", date: "2022-03-19", file: "SecondPost",tags: [.Swift, .iOS], thumb: "/images/strongImage.png"),
    IndexpostInfo(title: "Second post", context: "첫번째 포스트 입니다.", date: "2022-03-19", file: "SecondPost",tags: [.Swift, .iOS], thumb: "/images/strongImage.png")
]

func routes(_ app: Application) throws {
    
    app.get { req in
        return req.view.render("index", IndexData(root: "http://127.0.0.1:8080/", posts: postData, allTags: [.Swift, .iOS]))
    }
    
    app.get("posts", ":name") { req -> EventLoopFuture<View> in
        let page = req.parameters.get("name")!
        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/\(page).md")
        let parser = MarkdownParser()
        let result = parser.parse(templateString)
        let dateString = result.metadata["date"]
        let description = result.metadata["description"]
        let tags = result.metadata["tags"]
        let thumbnail = result.metadata["thumbnail"]
        
        print(tags)
        print(thumbnail)
        
        let html = result.html
        return req.view.render("post", ["name": html])
    }
}
