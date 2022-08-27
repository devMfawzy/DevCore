//
//  DevNetworkingTests.swift
//  DevCoreTests
//
//  Created by Mohamed Fawzy on 27/08/2022.
//

import XCTest
@testable import DevCore

final class DevNetworkingTests: XCTestCase {
    func testLoadDataCall() {
        let manager = DevCore.Networking.Manager()
        let expectaion = XCTestExpectation(description: "called for data")
        guard let url = URL(string: "https://www.apple.com") else {
            fatalError("Could not create url properly")
        }
        manager.loadData(from: url) { result in
            expectaion.fulfill()
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for: [expectaion], timeout: 5)
    }

    static var allTests = [
        ("testLoadDataCall", testLoadDataCall)
    ]
}
