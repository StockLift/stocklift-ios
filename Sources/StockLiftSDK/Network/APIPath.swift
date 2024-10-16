//
//  APIPath.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public enum APIPath {
    public enum v1 {
        // PLAID
        public static let plaidLinkToken = "v1/plaid/token"
        
        // PORTFOLIO
        public static let portfolio = "v1/portfolio"
        
        // CHARTS (coming soon)
        public static let sectorChart = "v1/chart/sector"
        public static let growthChart = "v1/chart/growth"
        public static let performanceChart = "v1/chart/performance"
        
    }
}
