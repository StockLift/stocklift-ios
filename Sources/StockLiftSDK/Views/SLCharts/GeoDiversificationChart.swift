//
//  GeoDiversificationChart.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/24/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct GeoDiversificationChart: View {
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
    let headerFont: Font
    let headerFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    
    init(
        _ viewModel: PortfolioViewModel,
        chartHeader: String = "Geo Diversification",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        subHeaderFont: Font = .caption,
        subHeaderFontColor: Color = .primary
    ) {
        self.portfolioVM = viewModel
        self.chartHeader = chartHeader
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.subHeaderFont = subHeaderFont
        self.subHeaderFontColor = subHeaderFontColor
    }
    
    var body: some View {
        VStack {
            // MAP CHART - Asset Locations
            if let annotations = self.portfolioVM.assetCoordinates, let geoAssets = portfolioVM.geoAssets {
                AssetMapView(
                    annotations: annotations,
                    missingSymbols: portfolioVM.missingSymbols, 
                    usersAssets: geoAssets,
                    chartHeader: chartHeader,
                    date: $portfolioVM.dateConnected,
                    hasCostBasis: $portfolioVM.hasCostBasis,
                    headerFont: headerFont,
                    headerFontColor: headerFontColor,
                    subHeaderFont: subHeaderFont,
                    subHeaderFontColor: subHeaderFontColor
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
    
    private func plaidError() {
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}


