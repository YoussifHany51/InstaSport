//
//  DateOptimizerTests.swift
//  InstaSportTests
//
//  Created by Youssif Hany on 20/08/2024.
//

import XCTest
@testable import InstaSport

final class DateOptimizerTests: XCTestCase {
    
    func testCurrentDate() {
        let expectedDate = getFormattedDate(for: Date())
        XCTAssertEqual(DateOptimizer.currentDate, expectedDate)
    }
    
    func testOneYearAfter() {
        let expectedDate = getFormattedDate(for: Calendar.current.date(byAdding: .month, value: 1, to: Date())!)
        XCTAssertEqual(DateOptimizer.oneYearAfter, expectedDate)
    }
    
    func testOneYearBefore() {
        let expectedDate = getFormattedDate(for: Calendar.current.date(byAdding: .month, value: -1, to: Date())!)
        XCTAssertEqual(DateOptimizer.oneYearBefore, expectedDate)
    }
    
    private func getFormattedDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
