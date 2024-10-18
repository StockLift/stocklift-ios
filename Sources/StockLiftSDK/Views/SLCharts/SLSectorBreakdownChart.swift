//
//  SectorChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/21/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 15.0, *)
public struct SLSectorBreakdownChart: View {
    @StateObject private var portfolioVM = PortfolioViewModel()
    
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
    // Chart
    let font: Font
    let fontColor: Color
    let headerFont: Font
    let headerFontColor: Color
    
    public init(
        _ chartHeader: String = "Diversification by Sector",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .body,
        linkAccountFontColor: Color = .black,
        font: Font = .caption,
        fontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary
    ) {
        self.chartHeader = chartHeader
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.font = font
        self.fontColor = fontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
    }
    
    //  Body
    public var body: some View {
        Group {
            if let entries = portfolioVM.sectorEntries {
                VStack {
                    /// Chart Header
                    Text(chartHeader)
                        .font(headerFont)
                        .foregroundStyle(headerFontColor)
                        .padding(.bottom, 8)
                    
                    HStack {
                        /// PIE CHART ** SP 500 Sector
                        PieChartView(values: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.value },
                                     colors: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.color })
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
                        .padding(.vertical)
                        .padding(.horizontal, 14)
                    }
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
                .appFontMedium(size: 16)
            
            Text(entry.label)
                .appFontRegular(size: 11)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        //        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.gray)
        .cornerRadius(22)
    }
    
    private func plaidError() {
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
    
}

