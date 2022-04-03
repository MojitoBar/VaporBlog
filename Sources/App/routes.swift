import Vapor
import LeafMarkdown
import Ink

enum Tag: String, Encodable {
    case ALL = "ALL"
    case Swift = "Swift"
    case iOS = "iOS"
    case Vapor = "Vapor"
}

let allTags: [Tag] = [.ALL, .Swift, .iOS, .Vapor]

struct IndexData: Encodable {
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
    let contents: [String]
    let file: String
}


func routes(_ app: Application) throws {
    
    app.get { req in
        return req.view.render("index", IndexData(posts: postDatas, allTags: allTags, selectTag: nil))
    }
    
    app.get("tag", ":tag") { req -> EventLoopFuture<View> in
        let selectTag: Tag = Tag(rawValue: req.parameters.get("tag")!)!
        let data = dataFilter(postDatas: postDatas, filter: selectTag)
        
        return req.view.render("index", IndexData(posts: data, allTags: allTags, selectTag: selectTag))
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
        let contents = result.metadata["contents"]!.split(separator: "/").map{ $0.description }
        let file = result.metadata["file"]!
        
        let html = insertString(html: result.html, contents: contents)
        return req.view.render("post", Post(date: dateString, description: description, thumbnail: thumbnail, tag: tags, html: html, oneline: oneline, contents: contents, file: file))
    }
}


func dataFilter(postDatas: [IndexpostInfo], filter: Tag) -> [IndexpostInfo] {
    var filterArr: [IndexpostInfo] = []
    
    for i in postDatas {
        if i.tags.contains(filter) || filter == .ALL{
            filterArr.append(i)
        }
    }
    
    return filterArr
}

func insertString(html: String, contents: [String]) -> String {
    var HTML = html
    var counts = HTML.matching(pattern: "<h2>")
    var index = 0
    print(contents)
    for i in 0..<contents.count {
        HTML.insert(contentsOf: "<section id=\"\(contents[i])\">", at: HTML.index(HTML.startIndex, offsetBy: counts[i] - 1))
        counts = counts.map{ $0 + contents[i].count + 15}
        index += 1
    }
    counts = HTML.matching(pattern: "</h2>")
    for i in 0..<contents.count {
        HTML.insert(contentsOf: "</section>", at: HTML.index(HTML.startIndex, offsetBy: counts[i] + 4))
        counts = counts.map{ $0 + 10 }
    }
    print(HTML)
    return HTML
}

extension String{
    func matching(pattern: String) -> [Int]{
        let str = Array(self)
        let pat = Array(pattern)
        var loc = [Int]()
        var pi = Array(repeatElement(0, count: pat.count))
        var i = 1,j = 0
        while i < pat.count{
            while j != 0 && pat[j] != pat[i] {
                j = pi[j-1]
            }
            if pat[j] == pat[i]{
                j += 1
                pi[i] = j
            }
            i += 1
        }
        i = 0;j = 0
        while  i < str.count {
            while j != 0 && pat[j] != str[i]{
                j = pi[j-1]
            }
            if pat[j] == str[i]{
                j += 1
                if j == pat.count{
                    loc.append(i - j + 2)
                    j = pi[j-1]
                }
            }
            i += 1
        }
        return loc
    }
}
