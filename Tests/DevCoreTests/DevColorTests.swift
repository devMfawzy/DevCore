import XCTest
@testable import DevCore

final class DevColorTests: XCTestCase {
    func testColor_passed_hexString_should_return_corosponding_UIColor() throws {
        let color = DevCore.Color.fromHexString("00FF00")
        XCTAssertEqual(color, .green)
    }
    
    func testRazeColorsAreEqual() {
        let color = DevCore.Color.fromHexString("006736")
        XCTAssertEqual(color, DevCore.Color.razeColor)
    }
    
    static var allTest = [
        ("testColor_passed_hexString_should_return_corosponding_UIColor", testColor_passed_hexString_should_return_corosponding_UIColor),
         ("testRazeColorsAreEqual", testRazeColorsAreEqual)
    ]
}
