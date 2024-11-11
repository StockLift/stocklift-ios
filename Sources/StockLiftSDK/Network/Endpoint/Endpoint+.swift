//
//  Endpoint+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

extension Endpoint {
    // MARK: - PLAID
    /// - LINK TOKEN
    static func plaidLinkToken(companyName: String? = nil) -> Self {
        let queryItems: [URLQueryItem] = [
            .init(name: "companyName", value: companyName)
        ]
        return Endpoint(path: APIPath.v1.plaidLinkToken, queryItems: queryItems)
    }
    
    /// - ASSET IMAGE URL
    static func getAssetImage(_ symbol: String) -> Self {
        Endpoint(path: APIPath.v1.portfolio + "/image" + "/\(symbol)")
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
