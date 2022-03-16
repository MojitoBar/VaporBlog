import Vapor
import LeafMarkdown
import Ink

func routes(_ app: Application) throws {
    app.get { req in
        return "<h1>asdf</h1>"
    }

//    
//    app.get("bye") { req -> EventLoopFuture<View> in
//        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/SecondPost.md")
//        return req.view.render("hello", ["data", templateString])
//    }
    
    app.get("bye") { req -> EventLoopFuture<View> in
        
        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/SecondPost.md")
        let parser = MarkdownParser()
        let result = parser.parse(templateString)
        let dateString = result.metadata["date"]
        let html = result.html
        return req.view.render("hello", ["name": html])
    }
        
    
    app.get("hello", ":name") { req -> EventLoopFuture<View> in
        let page = req.parameters.get("name")!
        let templateString = try String(contentsOfFile: app.directory.workingDirectory + "Resources/Views/Posts/\(page).md")
        print(app.directory.workingDirectory)
        
        // 1. 인스턴스 생성 - 동일
        let fileManager = FileManager.default

        // 2. 도큐먼트 URL 가져오기 - 동일
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentsURL = URL(fileURLWithPath: app.directory.workingDirectory)
        
        // 3. 파일들을 저장할 Directory 설정
        let directoryURL = documentsURL.appendingPathComponent("Resources/Views/")
        
        print(documentsURL)
        print(directoryURL)
        
        let parser = MarkdownParser()
        let result = parser.parse(templateString)
        let dateString = result.metadata["date"]
        let html = result.html
        
        
        // 4. 저장할 파일 이름 (확장자 필수)
        let helloPath = directoryURL.appendingPathComponent("test.leaf")
        // 파일에 들어갈 string
        
        do {
            // 4-1. 파일 생성
            try html.write(to: helloPath, atomically: false, encoding: .utf8)
        }catch let error as NSError {
            print("Error creating File : \(error.localizedDescription)")
        }
        
        return req.view.render("test", ["data": html])
    }
}

func convert(string: String, fileName: String, directory: String) {
    // 1. 인스턴스 생성 - 동일
    let fileManager = FileManager.default

    // 2. 도큐먼트 URL 가져오기 - 동일
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    // 3. 파일들을 저장할 Directory 설정
    let directoryURL = documentsURL.appendingPathComponent("Test_Folder")
    
    
    do {
        // 3-1. 폴더 생성
        try fileManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: false, attributes: nil)
    } catch let e {
        // 3-2. 오류 처리
        print(e.localizedDescription)
    }
    
    // 4. 저장할 파일 이름 (확장자 필수)
    let helloPath = directoryURL.appendingPathComponent("\(fileName).leaf")
    // 파일에 들어갈 string
    let text = string
    
    do {
        // 4-1. 파일 생성
        try text.write(to: helloPath, atomically: false, encoding: .utf8)
    }catch let error as NSError {
        print("Error creating File : \(error.localizedDescription)")
    }
}
