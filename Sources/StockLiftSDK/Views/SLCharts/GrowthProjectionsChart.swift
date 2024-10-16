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
    @StateObject private var portfolioVM = PortfolioViewModel()
    
    let chartHeader: String
    let height: CGFloat
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountHeader: String
    let chartForegroundColor: Color
    let chartForegroundBorderColor: Color
    
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
        linkAccountBackgroundColor: Color = .black,
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        chartForegroundColor: Color = .black,
        chartForegroundBorderColor: Color = .white
    ) {
        self.chartHeader = chartHeader
        self.height = height
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountHeader = linkAccountHeader
        self.chartForegroundColor = chartForegroundColor
        self.chartForegroundBorderColor = chartForegroundBorderColor    
    }
    
    public var body: some View {
        VStack {
            if let chartData = portfolioVM.growthChartEntries {
                // --- HAS ACCOUNT CONNECTED Chart View
                Text(chartHeader)
                    .appFontRegular()
//                    .padding(.top)
                Spacer()
                LineChart(chartData: chartData,
                          foregroundColor: chartForegroundColor,
                          foregroundBorderColor: chartForegroundBorderColor,
                          dateType: .all)
                    .frame(height: height)
//                    .padding(.horizontal)
//                    .padding(.bottom, 28)
//                    .padding(.top)
                

                
            } else {
                // --- NO ACCOUNT DATA view
                // Link Plaid flow
                LinkAccountView(plaidError: plaidError,
                                getPortfolio: getPortfolio,
                                foregroundColor: linkAccountForegroundColor,
                                backgroundColor: linkAccountBackgroundColor,
                                linkAccountHeader: linkAccountHeader
                )
                .padding()
                .padding(.bottom)

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
