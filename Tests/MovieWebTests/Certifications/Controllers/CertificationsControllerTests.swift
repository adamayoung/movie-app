//
//  CertificationsControllerTests.swift
//  Movie API
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Leaf
import MovieDomain
@testable import MovieWeb
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
