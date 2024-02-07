//
//  CertificationsContextMapperTests.swift
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

import MovieDomain
@testable import MovieWeb
import XCTest

final class CertificationsContextMapperTests: XCTestCase {

    func testMap() {
        let certifications = [
            "GB": [
                Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 1),
                Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 2)
            ],
            "US": [
                Certification(code: "DEF-US", meaning: "Some DEF-US meaning", order: 1),
                Certification(code: "ABC-US", meaning: "Some ABC-US meaning", order: 2)
            ]
        ]

        let result = CertificationsContextMapper.map(certifications)

        XCTAssertEqual(result.countryGroups.count, 2)

        XCTAssertEqual(result.countryGroups[0].countryCode, "GB")
        XCTAssertEqual(result.countryGroups[1].countryCode, "US")

        XCTAssertEqual(result.countryGroups[0].certifications.map(\.code), ["DEF-GB", "ABC-GB"])
        XCTAssertEqual(result.countryGroups[1].certifications.map(\.code), ["DEF-US", "ABC-US"])
    }

}
