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
    let gainColor: Color
    let lossColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let nameFont: Font
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
        gainColor: Color,
        lossColor: Color,
        assetDefaultColor: Color,
        symbolFont: Font,
        nameFont: Font,
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
        self.gainColor = gainColor
        self.lossColor = lossColor
        self.assetDefaultColor = assetDefaultColor
        self.symbolFont = symbolFont
        self.nameFont = nameFont
        self.assetDetailsHeaderFont = assetDetailsHeaderFont
        self.assetDetailsBodyFont = assetDetailsBodyFont
        self.assetDetailsHighlightColor = assetDetailsHighlightColor
    }
    
    var body: some View {
        VStack {
            // MAP CHART - Asset Locations
            if let annotations = self.portfolioVM.assetCoordinates, let geoAssets = portfolioVM.geoAssets {
                AssetMapView(
                    showDisclaimer: $showDisclaimer,
                    assetImages: $portfolioVM.assetImages,
                    annotations: annotations,
                    usersAssets: geoAssets,
                    chartHeader: chartHeader,
                    date: $portfolioVM.dateConnected,
                    hasCostBasis: $portfolioVM.hasCostBasis,
                    headerFont: headerFont,
                    headerFontColor: headerFontColor,
                    subHeaderFont: subHeaderFont,
                    subHeaderFontColor: subHeaderFontColor,
                    gainColor: gainColor,
                    lossColor: lossColor,
                    assetDefaultColor: assetDefaultColor,
                    symbolFont: symbolFont,
                    nameFont: nameFont,
                    assetDetailsHeaderFont: assetDetailsHeaderFont,
                    assetDetailsBodyFont: assetDetailsBodyFont,
                    assetDetailsHighlightColor: assetDetailsHighlightColor
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


