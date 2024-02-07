import Leaf
@testable import MovieWeb
import MovieDomain
import XCTVapor

final class CertificationsControllerTests: XCTestCase {

    var app: Application!
    var fetchMovieCertificationsUseCase: FetchMovieCertificationsStubUseCase!
    var fetchTVSeriesCertificationsUseCase: FetchTVSeriesCertificationsStubUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchMovieCertificationsUseCase = FetchMovieCertificationsStubUseCase()
        fetchTVSeriesCertificationsUseCase = FetchTVSeriesCertificationsStubUseCase()

        app = Application(.testing)

        let fileMiddleware = FileMiddleware(publicDirectory: app.directory.publicDirectory)
        app.middleware.use(fileMiddleware)

        app.views.use(.leaf)

        try app.register(
            collection: CertificationsController(
                fetchMovieCertificationsUseCase: fetchMovieCertificationsUseCase,
                fetchTVSeriesCertificationsUseCase: fetchTVSeriesCertificationsUseCase
            )
        )
    }

    override func tearDown() {
        app.shutdown()
        app = nil
        fetchTVSeriesCertificationsUseCase = nil
        fetchMovieCertificationsUseCase = nil
        super.tearDown()
    }

    func testShowMovies() throws {
        let certifications = [
            "GB": [
                MovieDomain.Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 1),
                MovieDomain.Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 2)
            ],
            "US": [
                MovieDomain.Certification(code: "ABC", meaning: "Some ABC meaning", order: 1),
                MovieDomain.Certification(code: "DEF", meaning: "Some DEF meaning", order: 2)
            ]
        ]
        fetchMovieCertificationsUseCase.result = .success(certifications)

        try app.test(.GET, "certifications/movies", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }

}
