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
    
}
