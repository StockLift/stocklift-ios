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
}
