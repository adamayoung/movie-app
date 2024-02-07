@testable import MovieWeb
import MovieDomain
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
