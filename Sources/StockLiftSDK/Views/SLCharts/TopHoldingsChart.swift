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
    
    let symbolFont: Font
    let symbolFontColor: Color
    let nameFont: Font
    let nameFontColor: Color
    let totalPercentColor: Color
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    init(
        _ viewModel: PortfolioViewModel,
        showDisclaimer: Binding<Bool>,
        chartHeader: String,
        linkAccountHeader: String,
        linkAccountForegroundColor: Color,
        linkAccountBackgroundColor: Color,
        linkAccountBorderColor: Color,
        linkAccountConnectSize: CGFloat,
        linkAccountFont: Font,
        linkAccountFontColor: Color,
        plaidError: @escaping () -> Void,
        getPortfolio: @escaping () -> Void,
        headerFont: Font,
        headerFontColor: Color,
        subHeaderFont: Font,
        subHeaderFontColor: Color,
        buttonColor: Color,
        buttonFontColor: Color,
        buttonFont: Font,
        assetDefaultColor: Color,
        gainColor: Color,
        lossColor: Color,
        symbolFont: Font, // main symbol and rank
        symbolFontColor: Color,
        nameFont: Font, // name of asset
        nameFontColor: Color,
        totalPercentColor: Color,
        assetDetailsHeaderFont: Font,
        assetDetailsBodyFont: Font,
        assetDetailsHighlightColor: Color
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
        self.symbolFont = symbolFont
        self.symbolFontColor = symbolFontColor
        self.nameFont = nameFont
        self.nameFontColor = nameFontColor
        self.totalPercentColor = totalPercentColor
        self.assetDetailsHeaderFont = assetDetailsHeaderFont
        self.assetDetailsBodyFont = assetDetailsBodyFont
        self.assetDetailsHighlightColor = assetDetailsHighlightColor
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
                    urls: $portfolioVM.assetImages,
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
                    symbolFont: symbolFont,
                    symbolFontColor: symbolFontColor,
                    nameFont: nameFont,
                    nameFontColor: nameFontColor,
                    totalPercentColor: totalPercentColor,
                    assetDetailsHeaderFont: assetDetailsHeaderFont,
                    assetDetailsBodyFont: assetDetailsBodyFont,
                    assetDetailsHighlightColor: assetDetailsHighlightColor
                )
                
            } else if portfolioVM.isLoadingPortfolioData {
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
