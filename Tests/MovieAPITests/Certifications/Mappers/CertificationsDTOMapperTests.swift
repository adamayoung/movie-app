//
//  CertificationsDTOMapperTests.swift
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

@testable import MovieAPI
import MovieDomain
import XCTest

final class CertificationsDTOMapperTests: XCTestCase {

    func testMap() {
        let certifications = [
            "GB": [
                Certification(code: "DEF-GB", meaning: "Some DEF-GB meaning", order: 1),
                Certification(code: "ABC-GB", meaning: "Some ABC-GB meaning", order: 2)
            ],
            "US": [
                Certification(code: "DEF", meaning: "Some DEF meaning", order: 1),
                Certification(code: "ABC", meaning: "Some ABC meaning", order: 2)
            ]
        ]

        let result = CertificationsDTOMapper.map(certifications)

        XCTAssertEqual(result.keys.map { $0 }, certifications.keys.map { $0 })

        XCTAssertEqual(result["GB"]?.map(\.order), [1, 2])
        XCTAssertEqual(result["US"]?.map(\.order), [1, 2])
    }

}
