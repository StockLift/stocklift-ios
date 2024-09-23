//
//  PortfolioChartResponse.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/3/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct PortfolioChartResponse: Codable {
    public let success: Bool
    public let portfolioChange: String?
    public let spTimeSeries: [UserTimeSeries]
    public let portfolioTimeSeries: [UserTimeSeries]
    
    public init(success: Bool, portfolioChange: String?, spTimeSeries: [UserTimeSeries], portfolioTimeSeries: [UserTimeSeries]) {
        self.success = success
        self.portfolioChange = portfolioChange
        self.spTimeSeries = spTimeSeries
        self.portfolioTimeSeries = portfolioTimeSeries
    }
    
    enum CodingKeys: String, CodingKey {
        case success
        case portfolioChange = "portfolio_change"
        case spTimeSeries = "sp_500"
        case portfolioTimeSeries = "my_chart"
    }
}


public struct UserTimeSeries: Codable {
    public let date: String?
    public let value: Float?
    
    public init(date: String?, value: Float?) {
        self.date = date
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case date, value
    }
}
