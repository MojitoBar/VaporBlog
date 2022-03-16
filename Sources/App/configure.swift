import Vapor
import Leaf
import LeafMarkdown

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.directory.publicDirectory = "/Users/judongseok/Desktop/SwiftProject/BlogVapor/hello/Public"
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // register Leaf - leaf 등록
    app.views.use(.leaf)
//    app.views.use(.plaintext)
    app.leaf.cache.isEnabled = app.environment.isRelease
    app.leaf.tags["markdown"] = Markdown()
    // 경로 설정 변경
    app.leaf.configuration.rootDirectory = "/Users/judongseok/Desktop/SwiftProject/BlogVapor/hello/Resources/Views"
    
    // register routes
    try routes(app)
}
