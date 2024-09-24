//
//  Endpoint+Portfolio.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public extension Endpoint {
    /// PORTFOLIO
    static var getPortfolio: Self {
        Endpoint(path: APIPath.v1.portfolio)
    }
}
