//
//  Endpoint+Charts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public extension Endpoint {
    // CHARTS
    /// Sector
    static var getSectorChart: Self {
        Endpoint(path: APIPath.v1.sectorChart)
    }
    /// Growth
    static var getGrowthChart: Self {
        Endpoint(path: APIPath.v1.growthChart)
    }
    /// Performance
    static var getPerformanceChart: Self {
        Endpoint(path: APIPath.v1.performanceChart)
    }
}
