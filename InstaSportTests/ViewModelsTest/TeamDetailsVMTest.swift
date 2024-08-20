//
//  TeamDetailsVMTest.swift
//  InstaSportTests
//
//  Created by zyad Baset on 20/08/2024.
//

import XCTest
@testable import InstaSport
final class TeamDetailsVMTest: XCTestCase {

    var vm:TeamDetailsViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = TeamDetailsViewModel(teamKey: "96", sport: .football)
    }

    func testGetData(){
        let expectation = XCTestExpectation(description: "El'amod Win")
        vm?.getData {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(vm?.teamDetails)
        XCTAssertEqual(vm?.teamDetails?.teamName, "Juventus")
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
