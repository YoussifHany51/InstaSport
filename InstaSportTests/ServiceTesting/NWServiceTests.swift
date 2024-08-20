//
//  NWServiceTests.swift
//  InstaSportTests
//
//  Created by Youssif Hany on 20/08/2024.
//

import XCTest
@testable import InstaSport
import Alamofire

final class NWServiceTests: XCTestCase {
    
    func testFetchTeamDetails() {
        let expectation = self.expectation(description: "FetchTeamDetails")
        let nwService = NWService(checkSportOrLeague: true, checkUpComingOrLastEvents: true, sport: .football)
        
        nwService.fetchTeamDetails(teamId: "96") { data in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLeaguesAPIData() {
        let expectation = self.expectation(description: "FetchLeaguesAPIData")
        let nwService = NWService(checkSportOrLeague: true, checkUpComingOrLastEvents: true, sport: .football)
        
        nwService.fetchLeaguesAPIData { data in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

