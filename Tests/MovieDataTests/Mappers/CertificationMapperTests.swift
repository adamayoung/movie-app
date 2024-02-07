//
//  CertificationMapperTests.swift
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

final class CertificationMapperTests: XCTestCase {

    func testMap() {
        let tmdbCertification = TMDb.Certification(
            code: "ABC",
            meaning: "Some meaning",
            order: 2
        )

        let result = CertificationMapper.map(tmdbCertification)

        XCTAssertEqual(result.code, tmdbCertification.code)
        XCTAssertEqual(result.meaning, tmdbCertification.meaning)
        XCTAssertEqual(result.meaning, tmdbCertification.meaning)
    }

}