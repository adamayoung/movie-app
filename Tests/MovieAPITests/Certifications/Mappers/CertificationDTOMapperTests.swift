//
//  CertificationDTOMapperTests.swift
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

final class CertificationDTOMapperTests: XCTestCase {

    func testMap() {
        let certification = Certification(
            code: "ABC",
            meaning: "ABC meaning",
            order: 2
        )

        let result = CertificationDTOMapper.map(certification)

        XCTAssertEqual(result.code, certification.code)
        XCTAssertEqual(result.meaning, certification.meaning)
        XCTAssertEqual(result.order, certification.order)
    }

}
