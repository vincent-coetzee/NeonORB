import XCTest
@testable import Neon

final class NeonTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Neon().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
