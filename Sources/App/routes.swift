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
    let selectTag: Tag?
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

let root = "http://127.0.0.1:8080/"

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", IndexData(root: root, posts: postDatas, allTags: [.Swift, .iOS], selectTag: nil))
    }
    
    app.get("tag", ":tag") { req -> EventLoopFuture<View> in
        print(req.parameters.get("tag"))
        let selectTag: Tag = Tag(rawValue: req.parameters.get("tag")!)!
        let data = dataFilter(postDatas: postDatas, filter: selectTag)
        
        return req.view.render("index", IndexData(root: root, posts: data, allTags: [.Swift, .iOS], selectTag: selectTag))
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


func dataFilter(postDatas: [IndexpostInfo], filter: Tag) -> [IndexpostInfo] {
    var filterArr: [IndexpostInfo] = []
    
    for i in postDatas {
        if i.tags.contains(filter) {
            filterArr.append(i)
        }
    }
    
    return filterArr
}
