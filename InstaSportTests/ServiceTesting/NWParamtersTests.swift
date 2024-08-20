//
//  NWParamtersTests.swift
//  InstaSportTests
//
//  Created by Youssif Hany on 20/08/2024.
//

import XCTest
@testable import InstaSport

final class NWParamtersTests: XCTestCase {
    
    func testGetParamTeamsDetails() {
        let params = param().getParam(metValue: .teamsDetails, teamId: 96, from: "", to: "", leagueId: "")
        XCTAssertEqual(params["met"], "Teams")
        XCTAssertEqual(params["teamId"], "96")
        XCTAssertEqual(params["APIkey"], apiKey)
    }
    
    func testGetParamFixtures() {
        let params = param().getParam(metValue: .fixtures, teamId: 96, from: "", to: "", leagueId: "305")
        XCTAssertEqual(params["met"], "Fixtures")
        XCTAssertEqual(params["leagueId"], "305")
        XCTAssertEqual(params["APIkey"], apiKey)
    }
    
    func testGetParamLeagues() {
        let params = param().getParam(metValue: .leagues, teamId: 96, from: "", to: "", leagueId: "")
        XCTAssertEqual(params["met"], "Leagues")
        XCTAssertEqual(params["APIkey"], apiKey)
    }
}

