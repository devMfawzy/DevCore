//
//  DevNetworkingTests.swift
//  DevCoreTests
//
//  Created by Mohamed Fawzy on 27/08/2022.
//

import XCTest
@testable import DevCore

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completion: @escaping ((Data?, Error?) -> Void)) {
        completion(data, error)
    }
    
    func post(with request: URLRequest, completion: @escaping ((Data?, Error?) -> Void)) {
        completion(data, error)
    }
}

struct MockData: Codable, Equatable {
    let id: Int
    let name: String
}

final class DevNetworkingTests: XCTestCase {
    func testLoadDataCall() {
        let manager = DevCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(fileURLWithPath: "url---")
        let expectaion = XCTestExpectation(description: "called for data")
        manager.loadData(from: url) { result in
            expectaion.fulfill()
            switch result {
            case .success(let resultData):
                XCTAssertEqual(data, resultData, "managewr returned unexpected data ")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for: [expectaion], timeout: 5)
    }

    func testSendDataCall() {
        let session = NetworkSessionMock()
        let manager = DevCore.Networking.Manager()
        let sampleObject = MockData(id: 1, name: "Adam")
        let data = try? JSONEncoder().encode(sampleObject)
        session .data = data
        manager.session = session
        let url = URL(fileURLWithPath: "url---")
        let expectaion = XCTestExpectation(description: "called for data")
        manager.sendData(to: url, body: sampleObject) { result in
            expectaion.fulfill()
            switch result {
            case .success(let resultData):
                let resultObject = try? JSONDecoder().decode(MockData.self, from: resultData)
                XCTAssertEqual(resultObject, sampleObject, "manager returned unexpected object ")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for: [expectaion], timeout: 5)
    }
    
    static var allTests = [
        ("testLoadDataCall", testLoadDataCall),
        ("testSendDataCall", testSendDataCall)
    ]
}
