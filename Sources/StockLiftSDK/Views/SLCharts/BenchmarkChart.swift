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
    @Binding var showDisclaimer: Bool
    
    // Link Account
    let linkAccountHeader: String
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountBorderColor: Color
    let linkAccountConnectSize: CGFloat
    let linkAccountFont: Font
    let linkAccountFontColor: Color
    let plaidError: () -> Void
    let getPortfolio: () -> Void
    // Chart
    let chartHeader: String
    let height: CGFloat
    let sp500Colors: [Color]
    let portfolioColors: [Color]
    let xAxisFont: Font
    let xAxisFontColor: Color
    let yAxisFont: Font
    let yAxisFontColor: Color
    let headerFont: Font
    let headerFontColor: Color
    // Legend
    let legendFont: Font
    let legendTextColor: Color
    
    init (
        _ viewModel: PortfolioViewModel,
        showDisclaimer: Binding<Bool>,
        chartHeader: String = "Geographic Diversification",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        plaidError: @escaping () -> Void,
        getPortfolio: @escaping () -> Void,
        height: CGFloat = 250,
        sp500Colors: [Color] = [.yellow, .yellow],
        portfolioColors: [Color] = [.blue, .blue],
        xAxisFont: Font = .caption2,
        xAxisFontColor: Color = .secondary,
        yAxisFont: Font = .caption2,
        yAxisFontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        legendFont: Font, // caption2
        legendTextColor: Color // primary
    ) {
        self.portfolioVM = viewModel
        self._showDisclaimer = showDisclaimer
        self.chartHeader = chartHeader
        self.height = height
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.plaidError = plaidError
        self.getPortfolio = getPortfolio
        self.sp500Colors = sp500Colors
        self.portfolioColors = portfolioColors
        self.xAxisFont = xAxisFont
        self.xAxisFontColor = xAxisFontColor
        self.yAxisFont = yAxisFont
        self.yAxisFontColor = yAxisFontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.legendFont = legendFont
        self.legendTextColor = legendTextColor
    }
    
    
    var body: some View {
        VStack {
            if let chartEntries = portfolioVM.portfolioChartEntries, let sp500ChartEntries = portfolioVM.sp500ChartEntries {
                Text(chartHeader)
                    .font(headerFont)
                    .foregroundColor(headerFontColor)
                    .underline(color: headerFontColor)
                    .overlay(alignment: .trailing) {
                        DisclaimerImage(showDisclaimer: $showDisclaimer, headerFontColor: headerFontColor)
                    }
                
                BarLineChart(
                    selectedElement: nil,
                    portfolioChartData: chartEntries,
                    sp500ChartData: sp500ChartEntries,
                    sp500Colors: sp500Colors,
                    portfolioColors: portfolioColors,
                    xAxisFont: xAxisFont,
                    xAxisFontColor: xAxisFontColor,
                    yAxisFont: yAxisFont,
                    yAxisFontColor: yAxisFontColor
                )
                
                LegendFooter(
                    sp500Color: sp500Colors[0],
                    portfolioColor: portfolioColors[0],
                    legendFont: legendFont,
                    legendTextColor: legendTextColor
                )
                .padding(.vertical, 6)
                
            } else if portfolioVM.isLoadingBenchmarkData || portfolioVM.isLoadingPortfolioData {
                ProgressView()
            } else {

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
            }
        }
    }
}

