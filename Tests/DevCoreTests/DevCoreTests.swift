import XCTest
@testable import DevCore

final class DevCoreTests: XCTestCase {
    func testColor_passed_hexString_should_return_corosponding_UIColor() throws {
        let color = DevCore.colorFromHexString("00FF00")
        XCTAssertEqual(color, .green)
    }
    
    static var allTest = [
        ("testColor_passed_hexString_should_return_corosponding_UIColor", testColor_passed_hexString_should_return_corosponding_UIColor)
    ]
}
