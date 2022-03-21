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

struct Post: Encodable {
    let date: String
    let description: String
    let thumbnail: String
    let tag: String
    let html: String
    let oneline: String
}

func routes(_ app: Application) throws {
    
    app.get { req in
        return req.view.render("index", IndexData(root: "http://127.0.0.1:8080/", posts: postDatas, allTags: [.Swift, .iOS]))
    }
    
    app.get("posts", ":name") { req -> EventLoopFuture<View> in
        let page = req.parameters.get("name")!
        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/\(page).md")
        let parser = MarkdownParser()
        let result = parser.parse(templateString)
        let dateString = result.metadata["date"]!
        let description = result.metadata["description"]!
        let tags = "#" + result.metadata["tags"]!.components(separatedBy: ", ").joined(separator: " #")
        let thumbnail = result.metadata["thumbnail"]!
        let oneline = result.metadata["oneline"]!
        
        print(tags)
        print(thumbnail)
        
        let html = result.html
        return req.view.render("post", Post(date: dateString, description: description, thumbnail: thumbnail, tag: tags, html: html, oneline: oneline))
    }
}
