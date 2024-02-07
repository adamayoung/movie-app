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
