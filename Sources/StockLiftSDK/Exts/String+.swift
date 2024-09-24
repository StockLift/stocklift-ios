//
//  String+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

extension String {
    
    func toDateEST(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "EST") ?? TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func toDateNoZone(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let formatter = DateFormatter()
        //        formatter.timeZone = TimeZone(abbreviation: "EST") ?? TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    // Yahoo Dates
    // 2022-08-11T21:00:54Z
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    // Twelve Data time series for Charts
    var getDateFromTimeSeries: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST") ?? TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
