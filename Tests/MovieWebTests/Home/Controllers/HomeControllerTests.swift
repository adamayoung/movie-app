import Leaf
@testable import MovieWeb
import XCTVapor

final class HomeControllerTests: XCTestCase {

    var app: Application!

    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)

        let fileMiddleware = FileMiddleware(publicDirectory: app.directory.publicDirectory)
        app.middleware.use(fileMiddleware)

        app.views.use(.leaf)

        try app.register(collection: HomeController())
    }

    override func tearDown() {
        app.shutdown()
        app = nil
        super.tearDown()
    }

    func testIndex() throws {
        try app.test(.GET, "", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }

}
