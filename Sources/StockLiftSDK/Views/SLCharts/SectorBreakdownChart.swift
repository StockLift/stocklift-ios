//
//  SectorChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/21/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 16.0, *)
struct SectorBreakdownChart: View {
    @ObservedObject private var portfolioVM: PortfolioViewModel
    @Binding var showDisclaimer: Bool
    
    @State private var showBreakdown: Bool = false
    
    private var screenWidth: Double {
        let screen = UIScreen.main.bounds.width
        let value = screen - 150
        return value
    }
    
    // Header
    let chartHeader: String
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
    let headerFont: Font
    let headerFontColor: Color
    let detailFont: Font
    let detailFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    
    // DETAILS View
    let gainColor: Color
    let lossColor: Color
    let sectorHeaderFont: Font
    let sectorHeaderFontColor: Color
    let sectorSubHeaderFont: Font
    let sectorSubHeaderFontColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let fontColor: Color
    let nameFont: Font
    
    // Pop up details view
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    init(
        _ viewModel: PortfolioViewModel,
        showDisclaimer: Binding<Bool>,
        chartHeader: String = "Diversification by Sector",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .primary,
        plaidError: @escaping () -> Void,
        getPortfolio: @escaping () -> Void,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        detailFont: Font = .caption2,
        detailFontColor: Color = .primary,
        subHeaderFont: Font = .caption,
        subHeaderFontColor: Color = .primary,
        gainColor: Color = .blue,
        lossColor: Color = .red,
        sectorHeaderFont: Font = .callout,
        sectorHeaderFontColor: Color = .primary,
        sectorSubHeaderFont: Font = .caption2,
        sectorSubHeaderFontColor: Color = .primary,
        assetDefaultColor: Color = .blue,
        symbolFont: Font = .caption,
        fontColor: Color = .white,
        nameFont: Font = .caption,
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
        self.detailFont = detailFont
        self.detailFontColor = detailFontColor
        self.subHeaderFont = subHeaderFont
        self.subHeaderFontColor = subHeaderFontColor
        self.gainColor = gainColor
        self.lossColor = lossColor
        self.sectorHeaderFont = sectorHeaderFont
        self.sectorHeaderFontColor = sectorHeaderFontColor
        self.sectorSubHeaderFont = sectorSubHeaderFont
        self.sectorSubHeaderFontColor = sectorSubHeaderFontColor
        self.assetDefaultColor = assetDefaultColor
        self.symbolFont = symbolFont
        self.fontColor = fontColor
        self.nameFont = nameFont
        self.assetDetailsHeaderFont = assetDetailsHeaderFont
        self.assetDetailsBodyFont = assetDetailsBodyFont
        self.assetDetailsHighlightColor = assetDetailsHighlightColor
    }
    
    //  Body
    var body: some View {
        Group {
            if let entries = portfolioVM.sectorEntries {
                VStack {
                    /// Chart Header
                    Text(chartHeader)
                        .font(headerFont)
                        .foregroundColor(headerFontColor)
                        .underline(color: headerFontColor)
                        .overlay(alignment: .trailing) {
                            DisclaimerImage(showDisclaimer: $showDisclaimer, headerFontColor: headerFontColor)
                        }
                        .padding(.top, 12)
                    
                    HStack {
                        /// PIE CHART ** SP 500 Sector
                        PieChartView(
                            values: ChartUtility.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.value },
                            colors: ChartUtility.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.color }
                        )
                        .frame(width: screenWidth) // weird bug but it works 
                        .frame(width: screenWidth / 2)
                        .padding(.leading, 4)
                        
                        /// SECTOR ** SCROLL View
                        ScrollView(.vertical, showsIndicators: false) {
                            if let entries = portfolioVM.sectorEntries {
                                ForEach(ChartUtility.entriesForDiversification(entries, colors: PIE_CHART_COLORS)) { entry in
                                    SectorScrollViewCell(entry)
                                }
                            }
                        }
                        .setScrollBorderShading()
                        .padding(.vertical, 18)
                        .padding(.horizontal, 14)
                    }
                    
                    Text("View Breakdown")
                        .font(subHeaderFont)
                        .foregroundStyle(subHeaderFontColor)
                        .onTapGesture { showBreakdownView() }
                        .padding(.bottom)
                }
                .popover(isPresented: $showBreakdown) {
                    PortfolioDetails(
                        sectorDetailsVM: DetailsViewModel(sectDict: portfolioVM.sectorDetails),
                        assetImages: $portfolioVM.assetImages,
                        date: portfolioVM.dateConnected,
                        hasCostBasis: portfolioVM.hasCostBasis,
                        selectedSector: .none,
                        updateCostBasisAction: updateCostBasisAction,
                        gainColor: gainColor,
                        lossColor: lossColor,
                        sectorHeaderFont: sectorHeaderFont,
                        sectorHeaderFontColor: sectorHeaderFontColor,
                        sectorSubHeaderFont: sectorSubHeaderFont,
                        sectorSubHeaderFontColor: sectorSubHeaderFontColor,
                        assetDefaultColor: assetDefaultColor,
                        symbolFont: symbolFont,
                        fontColor: fontColor,
                        nameFont: nameFont,
                        assetDetailsHeaderFont: assetDetailsHeaderFont,
                        assetDetailsBodyFont: assetDetailsBodyFont,
                        assetDetailsHighlightColor: assetDetailsHighlightColor
                    )
                }
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
    
    private func SectorScrollViewCell(_ entry: PieChartData) -> some View {
        HStack {
            Circle()
                .foregroundColor(entry.color)
                .frame(width: 8, height: 8)
            Text(ChartUtility.amount(entry.value))
                .font(detailFont)
                .foregroundStyle(detailFontColor)
            Text(entry.label)
                .font(detailFont)
                .foregroundStyle(detailFontColor)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.tertiaryLabel))
        .cornerRadius(22)
    }
    
    private func updateCostBasisAction(_ symbol: String, value: Float) {
        //TODO: - setup
//        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
    
    private func showBreakdownView() {
        HapticTap.light()
        showBreakdown.toggle()
    }
}

