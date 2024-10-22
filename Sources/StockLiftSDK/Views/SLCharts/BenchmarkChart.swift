//
//  BenchmarkChart.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/22/24.
//

import SwiftUI

@available(iOS 16.0, *)
struct BenchmarkChart: View {
    @ObservedObject var portfolioVM: PortfolioViewModel
    
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
    
    init (
        _ viewModel: PortfolioViewModel,
        chartHeader: String = "My Portfolio vs. S&P 500",
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
            if let chartEntries = portfolioVM.portfolioChartEntries, let sp500ChartEntries = portfolioVM.sp500ChartEntries {
                Text(chartHeader)
                    .font(headerFont)
                    .foregroundColor(headerFontColor)
//                    .padding(.top)
                
                BarLineChart(portfolioChartData: chartEntries,
                             sp500ChartData: sp500ChartEntries,
                             dateType: .month)
                .frame(height: height)
//                .padding(.horizontal)
//                LegendFooter()
            } else if portfolioVM.isLoading == false {
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
        //TODO: -
    }
    
    private func getPortfolio() {
        //TODO: -
    }
}

