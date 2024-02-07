@testable import MovieWeb
import MovieDomain
import XCTest

final class CertificationContextMapperTests: XCTestCase {

    func testMap() {
        let certification = Certification(
            code: "ABC",
            meaning: "ABC meaning",
            order: 2
        )

        let result = CertificationContextMapper.map(certification)

        XCTAssertEqual(result.code, certification.code)
        XCTAssertEqual(result.meaning, certification.meaning)
    }

}
