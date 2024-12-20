//
//  GrowthProjectionsChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/21/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct ProjectionsChart: View {
    @ObservedObject private var portfolioVM: PortfolioViewModel
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
    let chartForegroundColor: Color
    let chartForegroundBorderColor: Color
    let xAxisFont: Font
    let xAxisFontColor: Color
    let yAxisFont: Font
    let yAxisFontColor: Color
    let headerFont: Font
    let headerFontColor: Color
    
    init(
        _ viewModel: PortfolioViewModel,
        showDisclaimer: Binding<Bool>,
        chartHeader: String = "Portfolio Growth Projections",
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
        chartForegroundColor: Color = Color(UIColor.tertiaryLabel),
        chartForegroundBorderColor: Color = .blue,
        xAxisFont: Font = .caption2,
        xAxisFontColor: Color = .secondary,
        yAxisFont: Font = .caption2,
        yAxisFontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary
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
        self.chartForegroundColor = chartForegroundColor
        self.chartForegroundBorderColor = chartForegroundBorderColor
        self.xAxisFont = xAxisFont
        self.xAxisFontColor = xAxisFontColor
        self.yAxisFont = yAxisFont
        self.yAxisFontColor = yAxisFontColor
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
                    .underline(color: headerFontColor)
                    .overlay(alignment: .trailing) {
                        DisclaimerImage(showDisclaimer: $showDisclaimer, headerFontColor: headerFontColor)
                    }
                
                Spacer()
                LineChart(
                    chartData: chartData,
                    foregroundColor: chartForegroundColor,
                    foregroundBorderColor: chartForegroundBorderColor,
                    xAxisFont: xAxisFont,
                    xAxisFontColor: xAxisFontColor,
                    yAxisFont: yAxisFont,
                    yAxisFontColor: yAxisFontColor
                )
                
            } else if portfolioVM.isLoadingPortfolioData {
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
