import XCTest
@testable import Neon

final class NeonTests: XCTestCase {
    func testNaming()
        {
        let orb = NeonORB()
        let name = ["a","b","c"].asCosName()
        let rootContext = orb.namingService()
        }

    static var allTests = [
        ("testExample", testExample),
    ]
}
