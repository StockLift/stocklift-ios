//
//  Date+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

extension Date {
    // Dynamic format
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.timeZone = TimeZone(abbreviation: "EST") ?? TimeZone.current
        dateformat.locale = Locale.current
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    // Send Date to server
    var iso8601: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
