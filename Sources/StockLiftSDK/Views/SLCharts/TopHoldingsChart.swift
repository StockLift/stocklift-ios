//
//  TopHoldingsChart.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/24/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct TopHoldingsChart: View {
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
    let headerFont: Font
    let headerFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    let buttonColor: Color
    let buttonFontColor: Color
    let buttonFont: Font
    let assetDefaultColor: Color
    let gainColor: Color
    let lossColor: Color
    
    init(
        _ viewModel: PortfolioViewModel,
        showDisclaimer: Binding<Bool>,
        chartHeader: String = "Top Holdings",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        plaidError: @escaping () -> Void,
        getPortfolio: @escaping () -> Void,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        subHeaderFont: Font = .caption,
        subHeaderFontColor: Color = .primary,
        buttonColor: Color = .yellow,
        buttonFontColor: Color = .white,
        buttonFont: Font = .caption,
        assetDefaultColor: Color = .blue,
        gainColor: Color = .green,
        lossColor: Color = .red
    ) {
        self.portfolioVM = viewModel
        self._showDisclaimer = showDisclaimer
        self.chartHeader = chartHeader
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.plaidError = plaidError
        self.getPortfolio = getPortfolio
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.subHeaderFont = subHeaderFont
        self.subHeaderFontColor = subHeaderFontColor
        self.buttonColor = buttonColor
        self.buttonFontColor = buttonFontColor
        self.buttonFont = buttonFont
        self.assetDefaultColor = assetDefaultColor
        self.gainColor = gainColor
        self.lossColor = lossColor
    }
    
    var body: some View {
        VStack {
            if let holdings = portfolioVM.userTopHoldings, !holdings.isEmpty, let netWorth = portfolioVM.netWorth {
                // TOP HOLDINGS
                TopHoldingsPortfolioView(
                    showDisclaimer: $showDisclaimer,
                    topHoldings: holdings,
                    totalNetValue: Decimal(Double(netWorth)),
                    hasCostBasis: portfolioVM.hasCostBasis,
                    chartHeader: chartHeader,
                    headerFont: headerFont,
                    headerFontColor: headerFontColor,
                    subHeaderFont: subHeaderFont,
                    subHeaderFontColor: subHeaderFontColor,
                    buttonColor: buttonColor,
                    buttonFontColor: buttonFontColor,
                    buttonFont: buttonFont,
                    assetDefaultColor: assetDefaultColor,
                    gainColor: gainColor,
                    lossColor: lossColor,
                    urls: portfolioVM.assetImages
                )
                
            } else if portfolioVM.isLoading {
                ProgressView()
            } else {
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
