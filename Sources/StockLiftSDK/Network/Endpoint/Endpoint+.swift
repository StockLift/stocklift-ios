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
    /// - GET PORTFOLIO (all charts)
    static func getPortfolio(_ clientId: String) -> Self {
        Endpoint(path: APIPath.v1.portfolio + "/\(clientId)")
    }
    
    /// - GET BENCHMARK Chart
    static func benchmarkChart(_ clientId: String) -> Self {
        Endpoint(path: APIPath.v1.portfolio + "/benchmark" + "/\(clientId)")
    }
    
    /// - GET GEO DIVERSIFICATION Chart
    static func geoDiversificationChart(_ clientId: String) -> Self {
        Endpoint(path: APIPath.v1.portfolio + "/geo_diversification" + "/\(clientId)")
    }

}
