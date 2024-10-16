//
//  ChartData.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public struct ChartData: Identifiable {
    public var id = UUID()
    public let date: String
    public let value: Double
    
    init(id: UUID = UUID(), date: String, value: Double) {
        self.id = id
        self.date = date
        self.value = value
    }
}
