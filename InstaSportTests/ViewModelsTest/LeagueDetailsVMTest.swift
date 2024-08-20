//
//  LeagueDetailsVMTest.swift
//  InstaSportTests
//
//  Created by zyad Baset on 20/08/2024.
//

import XCTest
@testable import InstaSport
final class LeagueDetailsVMTest: XCTestCase {
    var vm : LeagueDetailsViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = LeagueDetailsViewModel(sport: .football, leagueNum: "332", league: LeagueModel())
    }
    
    func testGetData_UpcomingEventsParsedCorrectly() {
        // Arrange
        let expectation = self.expectation(description: "Handler called for upcoming events")
        
        // Act
        vm!.getData {
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(error, "Handler was not called")
            
            // Validate that the upcoming events were parsed correctly
            XCTAssertGreaterThan(self.vm!.arrUpComingEvents.count, 0, "Upcoming events should have been parsed")
            XCTAssertGreaterThan(self.vm!.arrTeams.count, 0, "Teams should have been added")
        }
    }

    func testGetData_LastEventsParsedCorrectly() {
        // Arrange
        let expectation = self.expectation(description: "Handler called for last events")
        
        // Act
        vm!.getData {
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(error, "Handler was not called")
            
            // Validate that the last events were parsed correctly
            XCTAssertGreaterThan(self.vm!.arrlastEvent.count, 0, "Last events should have been parsed")
            XCTAssertGreaterThan(self.vm!.arrTeams.count, 0, "Teams should have been added")
        }
    }

    func testGetData_DefaultValuesAreSetWhenNoData() {
        // Arrange
        let expectation = self.expectation(description: "Handler called when no data")
        
        // Act
        vm!.getData {
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(error, "Handler was not called")
            
            // Validate default values are set
            XCTAssertGreaterThan(self.vm!.arrUpComingEvents.count, 0, "Default upcoming events should have been set")
            XCTAssertGreaterThan(self.vm!.arrlastEvent.count, 0, "Default last events should have been set")
            XCTAssertGreaterThan(self.vm!.arrTeams.count, 0, "Default teams should have been set")
        }
    }
         override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            vm=nil
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
