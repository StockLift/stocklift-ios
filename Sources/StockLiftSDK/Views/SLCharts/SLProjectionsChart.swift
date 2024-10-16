//
//  GrowthProjectionsChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/21/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SLProjectionsChart: View {
//    @StateObject private var growthChartVM = GrowthChartViewModel()
    @StateObject private var portfolioVM = PortfolioViewModel()
    
    let chartHeader: String
    let height: CGFloat
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountHeader: String
    let chartForegroundColor: Color
    let chartForegroundBorderColor: Color
    let font: Font
    let fontColor: Color
    let headerFont: Font
    let headerFontColor: Color
    
    /// Growth Chart Projections for users portfolio
    /// - Parameters:
    ///   - chartHeader: "Header for Chart"
    ///   - height: the height of the chart
    ///   - linkAccountForegroundColor: foreground color for link account view
    ///   - linkAccountBackgroundColor: background color for link account view
    ///   - linkAccountHeader: header title for link account view
    ///   - chartForegroundColor: chards area range color
    ///   - chartForegroundBorderColor: charts area range border color
    ///   - font: chart font style (system styles)
    ///   - fontColor: color of the chart font
    ///   - headerFont: chart header font
    ///   - headerFontColor: chart header font color
    public init(
        _ chartHeader: String = "Portfolio Growth Projections",
        height: CGFloat = 250,
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        chartForegroundColor: Color = .black,
        chartForegroundBorderColor: Color = .white,
        font: Font = .caption,
        fontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary
    ) {
        self.chartHeader = chartHeader
        self.height = height
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountHeader = linkAccountHeader
        self.chartForegroundColor = chartForegroundColor
        self.chartForegroundBorderColor = chartForegroundBorderColor
        self.font = font
        self.fontColor = fontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
    }
    
    public var body: some View {
        VStack {
            if let chartData = portfolioVM.growthChartEntries {
                // --- HAS ACCOUNT CONNECTED Chart View
                Text(chartHeader)
                    .font(headerFont)
                    .foregroundStyle(headerFontColor)
                    .padding(.bottom, 8)

                LineChart(
                    chartData: chartData,
                    foregroundColor: chartForegroundColor,
                    foregroundBorderColor: chartForegroundBorderColor,
                    font: font,
                    fontColor: fontColor
                )
                .frame(height: height)
                
            } else if portfolioVM.isLoading == false  {
                // --- NO ACCOUNT DATA view
                // Link Plaid flow
                LinkAccountView(plaidError: plaidError,
                                getPortfolio: getPortfolio,
                                foregroundColor: linkAccountForegroundColor,
                                backgroundColor: linkAccountBackgroundColor,
                                linkAccountHeader: linkAccountHeader
                )
                .padding()
            } else {
                ProgressView()
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
