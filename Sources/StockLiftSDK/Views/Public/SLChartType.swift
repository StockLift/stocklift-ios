//
//  SLChartType.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/29/24.
//

import Foundation

public enum SLChartType: Int, CaseIterable, Identifiable {
    public var id: Self { self }
    case portfolioSummary
    case sectorDiversification
    case geoDiversification
    case topHoldings
    case benchmarkPerformance
    case projectionsPerformance
    
    func tag(_ chartViews: [SLChartType]) -> Int {
        chartViews.firstIndex(of: self) ?? 0
    }
}
