//
//  LeagueVMTest.swift
//  InstaSportTests
//
//  Created by zyad Baset on 20/08/2024.
//

import XCTest
@testable import InstaSport
final class LeagueVMTest: XCTestCase {

    var vm:LeaguesViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //vm = LeaguesViewModel(sport: .football, checkFavorite: false)
    }

    func testInit_WithCheckFavoriteTrue_CallsReloadCoreData() {
            // Arrange
            let coreDataManager = CoreDataManager.shared
            let initialFavoriteCount = coreDataManager.fetchSavedLeagues().count
            
            // Act
            vm = LeaguesViewModel(sport: .football, checkFavorite: true)
            
            // Assert
            XCTAssertEqual(vm!.arrFav.count, initialFavoriteCount, "arrFav should be populated with fetched leagues from Core Data.")
        }
        
        func testInit_WithCheckFavoriteFalse_DoesNotCallReloadCoreData() {
            // Act
            vm = LeaguesViewModel(sport: .football, checkFavorite: false)
            
            // Assert
            XCTAssertEqual(vm!.arrFav.count, 0, "arrFav should remain empty when checkFavorite is false.")
        }
        
        func testGetData_PopulatesArrayOfLeagues() {
            // Arrange
            vm = LeaguesViewModel(sport: .football, checkFavorite: false)
            let expectation = self.expectation(description: "Handler called after data is fetched")
            
            // Act
            vm!.getData {
                expectation.fulfill()
            }
            
            // Assert
            waitForExpectations(timeout: 5.0) { error in
                XCTAssertNil(error, "Handler was not called")
                XCTAssertGreaterThan(self.vm!.arrayOfLeagues.count, 0, "arrayOfLeagues should be populated with fetched data.")
            }
        }
        
//        func testReloadCoreData_PopulatesArrFav() {
//            // Arrange
//            vm = LeaguesViewModel(sport: .football, checkFavorite: true)
//            
//            // Act
//            vm!.reloadCoreData()
//            
//            // Assert
//            XCTAssertGreaterThan(self.vm!.arrFav.count, 0, "arrFav should be populated with fetched leagues from Core Data after calling reloadCoreData.")
//        }
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
