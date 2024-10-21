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
        switch chartType {
        case .projections:
            SLProjectionsChart()
                .padding(4)
        case .benchmark:
            Text("Benchmark Coming Soon!")
                .padding(4)
        case .sector:
            SLSectorBreakdownChart()
        case .all:
            TabView {
                // Projections Chart
                SLProjectionsChart().tag(1)
                    .padding(4)
                
                // Benchmark
                Text("Benchmark Coming Soon!").tag(2)
                    .padding(4)
                
                // Sector Breakdown
                SLSectorBreakdownChart().tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}
