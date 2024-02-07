//
//  CertificationTMDbDataSourceTests.swift
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

@testable import MovieData
import MovieDomain
import TMDb
import XCTest

final class CertificationTMDbDataSourceTests: XCTestCase {

    var dataSource: CertificationTMDbDataSource!
    var certificationProvider: TMDbCertificationStubProvider!

    override func setUp() {
        super.setUp()
        certificationProvider = TMDbCertificationStubProvider()
        dataSource = CertificationTMDbDataSource(certificationProvider: certificationProvider)
    }

    override func tearDown() {
        dataSource = nil
        certificationProvider = nil
        super.tearDown()
    }

    func testMovieCertifications() async throws {
        let tmdbCertifications = [
            "GB": [
                TMDb.Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 2),
                TMDb.Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 1)
            ],
            "US": [
                TMDb.Certification(code: "DEF", meaning: "Some DEF meaning", order: 2),
                TMDb.Certification(code: "ABC", meaning: "Some ABC meaning", order: 1)
            ]
        ]

        let domainCertifications = [
            "GB": [
                MovieDomain.Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 1),
                MovieDomain.Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 2)
            ],
            "US": [
                MovieDomain.Certification(code: "ABC", meaning: "Some ABC meaning", order: 1),
                MovieDomain.Certification(code: "DEF", meaning: "Some DEF meaning", order: 2)
            ]
        ]

        certificationProvider.movieCertificationsResult = .success(tmdbCertifications)

        let result = try await dataSource.movieCertifications()

        XCTAssertEqual(result, domainCertifications)
    }

    func testTVSeriesCertifications() async throws {
        let tmdbCertifications = [
            "GB": [
                TMDb.Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 2),
                TMDb.Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 1)
            ],
            "US": [
                TMDb.Certification(code: "DEF", meaning: "Some DEF meaning", order: 2),
                TMDb.Certification(code: "ABC", meaning: "Some ABC meaning", order: 1)
            ]
        ]

        let domainCertifications = [
            "GB": [
                MovieDomain.Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 1),
                MovieDomain.Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 2)
            ],
            "US": [
                MovieDomain.Certification(code: "ABC", meaning: "Some ABC meaning", order: 1),
                MovieDomain.Certification(code: "DEF", meaning: "Some DEF meaning", order: 2)
            ]
        ]

        certificationProvider.tvSeriesCertificationsResult = .success(tmdbCertifications)

        let result = try await dataSource.tvSeriesCertifications()

        XCTAssertEqual(result, domainCertifications)
    }

}
