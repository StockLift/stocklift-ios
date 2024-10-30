//
//  SLChartType.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/29/24.
//

import Foundation

public enum SLChartType: Int, CaseIterable, Identifiable {
    public var id: Self { self }
    case sector
    case benchmark
    case projections
    case geoDiversification
    case topHoldings
    case portfolioSummary
    
    var tag: Int { self.rawValue }
}
