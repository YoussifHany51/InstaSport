//
//  DateOptimizer.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import Foundation
class DateOptimizer{
    static var currentDate:String{
        let currentDate = Date()
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        // Set the date format to "yyyy-MM-dd"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Convert the Date to a String
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    static var oneYearAfter:String{
        let currentDate = Date()
        // Use Calendar to add one year to the current date
        let oneYearAfter = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        // Set the date format to "yyyy-MM-dd"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Convert the Date (one year after) to a String
        let formattedDate = dateFormatter.string(from: oneYearAfter)
        return formattedDate
    }
    static var oneYearBefore:String {
        let currentDate = Date()
        // Use Calendar to add one year to the current date
        let oneYearBefore = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        // Set the date format to "yyyy-MM-dd"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Convert the Date (one year after) to a String
        let formattedDate = dateFormatter.string(from: oneYearBefore)
        return formattedDate
    }
    
}
