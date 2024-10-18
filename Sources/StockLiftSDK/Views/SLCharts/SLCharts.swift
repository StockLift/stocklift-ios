//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

public enum SLChartType {
    case projections
    case sector
    case benchmark
    case all
}

public struct SLCharts: View {
    let chartType: SLChartType
    
    public init(_ type: SLChartType = .all) {
        self.chartType = type
    }
    
    public var body: some View {
        Group {
            switch chartType {
            case .projections:
                SLProjectionsChart()
            case .benchmark:
                Text("Benchmark Coming Soon!")
            case .sector:
                SLSectorBreakdownChart()
            case .all:
                TabView {
                    // Projections Chart
                    SLProjectionsChart().tag(1)
                    
                    // Benchmark
                    Text("Benchmark Coming Soon!").tag(2)
                    
                    // Sector Breakdown
                    SLSectorBreakdownChart().tag(3)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            }
        }
    }
}
