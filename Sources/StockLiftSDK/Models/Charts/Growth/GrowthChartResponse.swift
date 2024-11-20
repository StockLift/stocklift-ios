//
//  GrowthChartResponse.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation


struct GrowthChartResponse: Codable {
    let data: [GrowthTimeline]
    
    init(data: [GrowthTimeline]) {
        self.data = data
    }
}
