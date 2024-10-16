//
//  Endpoint+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public extension Endpoint {
    // MARK: - PLAID
    /// - LINK TOKEN
    static var plaidLinkToken: Endpoint {
        Endpoint(path: APIPath.v1.plaidLinkToken)
    }
    
    // MARK: - PORTFOLIO
    /// - GET PORTFOLIO
    static var getPortfolio: Self {
        Endpoint(path: APIPath.v1.portfolio)
    }
    
    // MARK: - CHARTS (coming soon)
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
