//
//  GrowthProjectionsChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/21/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct GrowthProjectionsChart: View {
    
    @StateObject private var growthChartVM = GrowthChartViewModel()
    
    let chartHeader: String
    let height: CGFloat
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountHeader: String
    
    /// Growth Chart Projections for users portfolio
    /// - Parameters:
    ///   - chartHeader: "Header for Chart"
    ///   - height: the height of the chart
    ///   - linkAccountForegroundColor: foreground color for link account view
    ///   - linkAccountBackgroundColor: background color for link account view
    ///   - linkAccountHeader: header title for link account view
    public init(
        _ chartHeader: String = "Portfolio Growth Projections",
        height: CGFloat = 250,
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .yellow,
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments"
    ) {
        self.chartHeader = chartHeader
        self.height = height
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountHeader = linkAccountHeader
    }
    
    public var body: some View {
        VStack {
            if growthChartVM.growthChartEntries.isEmpty {
                // Link Plaid flow
                LinkAccountView(plaidError: plaidError,
                                getPortfolio: getPortfolio,
                                foregroundColor: linkAccountForegroundColor,
                                backgroundColor: linkAccountBackgroundColor,
                                linkAccountHeader: linkAccountHeader
                )
                .padding()
                .padding(.bottom)
                
            } else {
                Text(chartHeader)
                    .appFontRegular()
//                    .padding(.top)
                Spacer()
                LineChart(chartData: growthChartVM.growthChartEntries, dateType: .all)
                    .frame(height: height)
//                    .padding(.horizontal)
//                    .padding(.bottom, 28)
//                    .padding(.top)
            }
        }
        //        .makeCardLayer()
    }
    
    private func plaidError() {
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}
