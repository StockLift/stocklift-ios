//
//  Double+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

extension Double {
    func amountToPercent() -> String {
        var string = String(format: "%.2f", self)
        string.append("%")
        return string
    }
}
