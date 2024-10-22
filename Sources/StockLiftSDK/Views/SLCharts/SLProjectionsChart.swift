//
//  GrowthProjectionsChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/21/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct SLProjectionsChart: View {
    @ObservedObject private var portfolioVM: PortfolioViewModel
    
    // Link Account
    let linkAccountHeader: String
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountBorderColor: Color
    let linkAccountConnectSize: CGFloat
    let linkAccountFont: Font
    let linkAccountFontColor: Color
    // Chart
    let chartHeader: String
    let height: CGFloat
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
     init(
        _ viewModel: PortfolioViewModel,
        chartHeader: String = "Portfolio Growth Projections",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        height: CGFloat = 250,
        chartForegroundColor: Color = Color(UIColor.tertiaryLabel),
        chartForegroundBorderColor: Color = .blue,
        font: Font = .caption,
        fontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary
    ) {
        self.portfolioVM = viewModel
        self.chartHeader = chartHeader
        self.height = height
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor    
        self.chartForegroundColor = chartForegroundColor
        self.chartForegroundBorderColor = chartForegroundBorderColor
        self.font = font
        self.fontColor = fontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
    }
    
     var body: some View {
        VStack {
            if let chartData = portfolioVM.growthChartEntries {
                // --- HAS ACCOUNT CONNECTED Chart View
                /// Chart Header
                Text(chartHeader)
                    .font(headerFont)
                    .foregroundColor(headerFontColor)
//                    .padding(.top, 4)
                    
                Spacer()

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
                LinkAccountView(
                    linkAccountHeader: linkAccountHeader,
                    plaidError: plaidError,
                    getPortfolio: getPortfolio,
                    foregroundColor: linkAccountForegroundColor,
                    backgroundColor: linkAccountBackgroundColor,
                    borderColor: linkAccountBorderColor,
                    connectSize: linkAccountConnectSize,
                    font: linkAccountFont,
                    fontColor: linkAccountFontColor
                )
            } else {
                ProgressView()
            }
        }
    }
    
    private func plaidError() {
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}
