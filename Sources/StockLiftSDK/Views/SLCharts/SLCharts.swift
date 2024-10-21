//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

public enum SLChartType {
    case projections
    case sector
    case benchmark
    case all
}

@available(iOS 15.0, *)
public struct SLCharts: View {
    /// CHART Type to show
    var chartType: SLChartType
    // Header
    var projectionsChartHeader: String
    var benchmarkChartHeader: String
    var sectorChartHeader: String
    // Link Account
    var linkAccountHeader: String
    var linkAccountForegroundColor: Color
    var linkAccountBackgroundColor: Color
    var linkAccountBorderColor: Color
    var linkAccountConnectSize: CGFloat
    var linkAccountFont: Font
    var linkAccountFontColor: Color
    // Chart
    var height: CGFloat
    var chartForegroundColor: Color
    var chartForegroundBorderColor: Color
    var font: Font
    var fontColor: Color
    var headerFont: Font
    var headerFontColor: Color
    // Card Background
    var cardBackgroundColor: Color
    var cardCornerRadius: CGFloat
    var cardShadow: Bool
    
    public init(
        _ chartViewType: SLChartType = .all,
        projectionsChartHeader: String = "Portfolio Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. SP 500",
        sectorChartHeader: String = "Diversification by Sector",
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        height: CGFloat = 250,
        chartForegroundColor: Color = .black,
        chartForegroundBorderColor: Color = .white,
        font: Font = .caption,
        fontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        cardBackgroundColor: Color = .gray.opacity(0.3),
        cardCornerRadius: CGFloat = 14,
        cardShadow: Bool = true
    ) {
        self.chartType = chartViewType
        self.projectionsChartHeader = projectionsChartHeader
        self.benchmarkChartHeader = benchmarkChartHeader
        self.sectorChartHeader = sectorChartHeader
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.height = height
        self.chartForegroundColor = chartForegroundColor
        self.chartForegroundBorderColor = chartForegroundBorderColor
        self.font = font
        self.fontColor = fontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.cardBackgroundColor = cardBackgroundColor
        self.cardCornerRadius = cardCornerRadius
        self.cardShadow = cardShadow
    }
    
    public var body: some View {
        switch chartType {
        case .projections:
            SLProjectionsChart(
                projectionsChartHeader,
                height: height,
                linkAccountHeader: linkAccountHeader,
                linkAccountForegroundColor: linkAccountForegroundColor,
                linkAccountBackgroundColor:  linkAccountBackgroundColor,
                chartForegroundColor: chartForegroundColor,
                chartForegroundBorderColor: chartForegroundBorderColor,
                font: font,
                fontColor: fontColor,
                headerFont: headerFont,
                headerFontColor: headerFontColor
            )
            .padding(8)
        case .benchmark:
            //TODO: -----
            Text("Benchmark Coming Soon!")
                .padding(8)
        case .sector:
            SLSectorBreakdownChart(
                sectorChartHeader,
                //                    height: height,
                linkAccountHeader: linkAccountHeader,
                linkAccountForegroundColor: linkAccountForegroundColor,
                linkAccountBackgroundColor:  linkAccountBackgroundColor,
                font: font,
                fontColor: fontColor,
                headerFont: headerFont,
                headerFontColor: headerFontColor
            )
        case .all:
            TabView {
                // Projections Chart
                SLProjectionsChart(
                    projectionsChartHeader,
                    height: height,
                    linkAccountHeader: linkAccountHeader,
                    linkAccountForegroundColor: linkAccountForegroundColor,
                    linkAccountBackgroundColor:  linkAccountBackgroundColor,
                    chartForegroundColor: chartForegroundColor,
                    chartForegroundBorderColor: chartForegroundBorderColor,
                    font: font,
                    fontColor: fontColor,
                    headerFont: headerFont,
                    headerFontColor: headerFontColor
                )
                .tag(1)
                .padding(8)
                
                // Benchmark
                //TODO: -----
                Text("Benchmark Coming Soon!").tag(2)
                    .padding(8)
                
                // Sector Breakdown
                SLSectorBreakdownChart(
                    sectorChartHeader,
                    //                    height: height,
                    linkAccountHeader: linkAccountHeader,
                    linkAccountForegroundColor: linkAccountForegroundColor,
                    linkAccountBackgroundColor:  linkAccountBackgroundColor,
                    font: font,
                    fontColor: fontColor,
                    headerFont: headerFont,
                    headerFontColor: headerFontColor
                )
                .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .makeCardLayer(color: cardBackgroundColor)
            .frame(maxWidth: UIScreen.main.bounds.width / 1.05)
            .background(cardBackgroundColor.opacity(0.3))
            .cornerRadius(cardCornerRadius)
            .shadow(radius: cardShadow ? 8 : 0)
        }
    }
}
