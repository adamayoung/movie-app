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
