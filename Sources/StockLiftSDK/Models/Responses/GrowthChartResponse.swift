//
//  GrowthChartResponse.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation


public struct GrowthChartResponse: Codable {
    public let data: [GrowthTimeline]
    
    public init(data: [GrowthTimeline]) {
        self.data = data
    }
}
