////
////  DataParserTests.swift
////  InstaSportTests
////
////  Created by Youssif Hany on 20/08/2024.
////
//
//import XCTest
//@testable import InstaSport
//
//// Mock NWService for testing purposes
//protocol NWServiceProtocol {
//    func fetchLeaguesAPIData(leagueID: String, completion: @escaping (Data) -> Void)
//    func fetchTeamDetails(teamId: String, completion: @escaping (Data) -> Void)
//}
//class MockNWService :NWServiceProtocol{
//    var mockData: Data?
//    
//     func fetchLeaguesAPIData(leagueID: String, completion: @escaping (Data) -> Void) {
//        if let data = mockData {
//            completion(data)
//        } else {
//            completion(Data()) // Return empty data if no mock data is set
//        }
//    }
//    
//     func fetchTeamDetails(teamId: String, completion: @escaping (Data) -> Void) {
//        if let data = mockData {
//            completion(data)
//        } else {
//            completion(Data())
//        }
//    }
//}
//
//final class DataParserTests: XCTestCase {
//    var dataParser: DataParser!
//    var mockService: MockNWService!
//
//    override func setUp() {
//        super.setUp()
//        dataParser = DataParser()
//        mockService = MockNWService()
//    }
//
//    func testParsingFBDataSuccessfullyDecodesData() {
//        // Define test JSON data
//        let testJSON = """
//        {
//            "leagueKey": 305,
//            "leagueName": "Premier League",
//            "leagueLogo": "logo.png"
//        }
//        """.data(using: .utf8)!
//        
//        // Set the mock data
//        mockService.mockData = testJSON
//        
//        // Create an expectation
//        let expectation = XCTestExpectation(description: "Decoding should succeed and handler should be called")
//        
//        // Call the parsingFBData method
//        dataParser.parsingFBData(ClassType: LeagueModel.self, checkSportOrLeague: true, sport: .football) { decodedData in
//            XCTAssertEqual(decodedData.leagueKey, 305)
//            XCTAssertEqual(decodedData.leagueName, "Premier League")
//            XCTAssertEqual(decodedData.leagueLogo, "logo.png")
//            expectation.fulfill()
//        }
//        
//        // Wait for the expectation
//        wait(for: [expectation], timeout: 1.0)
//    }
//    
//    func testParsingTeamDataSuccessfullyDecodesData() {
//        // Define test JSON data
//        let testJSON = """
//        {
//            "teamKey": 1,
//            "teamName": "Manchester United"
//        }
//        """.data(using: .utf8)!
//        
//        // Set the mock data
//        mockService.mockData = testJSON
//        
//        // Create an expectation
//        let expectation = XCTestExpectation(description: "Decoding should succeed and handler should be called")
//        
//        // Call the ParsingTeamData method
//        dataParser.ParsingTeamData(sport: .football, teamKey: "1") { decodedData in
//            XCTAssertEqual(decodedData.success, 1)
//            expectation.fulfill()
//        }
//        
//        // Wait for the expectation
//        wait(for: [expectation], timeout: 1.0)
//    }
//}
//
