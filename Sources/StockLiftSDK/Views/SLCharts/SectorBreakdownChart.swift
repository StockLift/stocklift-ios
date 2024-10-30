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
        subHeaderFontColor: Color = .primary
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
                            values: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.value },
                            colors: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.color }
                        )
                        .frame(width: screenWidth)
                        .frame(width: screenWidth / 2)
                        .padding(.leading, 4)
                        
                        /// SECTOR ** SCROLL View
                        ScrollView(.vertical, showsIndicators: false) {
                            if let entries = portfolioVM.sectorEntries {
                                ForEach(PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS)) { entry in
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
                    PortfolioDetails(sectorDetailsVM: DetailsViewModel(sectDict: portfolioVM.sectorDetails),
                                     date: portfolioVM.dateConnected,
                                     hasCostBasis: portfolioVM.hasCostBasis,
                                     selectedSector: .none,
                                     updateCostBasisAction: updateCostBasisAction)
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
            Text(PortfolioChartUtils.amount(entry.value))
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
//        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
    
    private func showBreakdownView() {
        HapticTap.light()
        showBreakdown.toggle()
    }
}

