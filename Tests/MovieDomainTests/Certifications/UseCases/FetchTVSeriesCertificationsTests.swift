//
//  FetchTVSeriesCertificationsTests.swift
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

@testable import MovieDomain
import XCTest

final class FetchTVSeriesCertificationsTests: XCTestCase {

    var useCase: FetchTVSeriesCertifications!
    var dataSource: CertificationStubDataSource!

    override func setUp() {
        super.setUp()
        dataSource = CertificationStubDataSource()
        useCase = FetchTVSeriesCertifications(dataSource: dataSource)
    }

    override func tearDown() {
        useCase = nil
        dataSource = nil
        super.tearDown()
    }

    func testExecute() async throws {
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
        dataSource.tvSeriesCertificationsResult = .success(certifications)

        let result = try await useCase.execute()

        XCTAssertEqual(result, certifications)
    }

}
