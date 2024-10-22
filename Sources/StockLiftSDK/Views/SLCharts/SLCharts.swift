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
    @StateObject private var viewModel = PortfolioViewModel()
    
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
    var sectorDetailFont: Font
    var sectorDetailFontColor: Color
    // Card Background
    var cardBackgroundColor: Color
    var cardCornerRadius: CGFloat
    var cardShadow: Bool
    
    public init(
        _ chartViewType: SLChartType = .all,
        projectionsChartHeader: String = "Portfolio Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. SP 500",
        sectorChartHeader: String = "Diversification by Sector",
        
        // Link Account View
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .white,
        
        // Charts
        height: CGFloat = 250,
        chartForegroundColor: Color = Color(UIColor.tertiaryLabel),
        chartForegroundBorderColor: Color = .blue,
        font: Font = .caption,
        fontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        sectorDetailFont: Font = .caption2,
        sectorDetailFontColor: Color = .primary,
        
        // Card
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
        self.sectorDetailFont = sectorDetailFont
        self.sectorDetailFontColor = sectorDetailFontColor
    }
    
    public var body: some View {
        switch chartType {
        case .projections:
            /// ------------ Projections Chart
            ProjectionsChart
                .padding(8)
        case .benchmark:
            /// ------------ Benchmark Chart
            BenchmarkChart
                .padding(8)
        case .sector:
            /// ------------ Sector Breakdown Chart
            SectorChart
        case .all:
            TabView {
                /// ------------ Sector Breakdown Chart
                SectorChart
                    .tag(0)
                /// ------------ Projections Chart
                ProjectionsChart
                    .tag(1)
                    .padding(8)
                /// ------------ Benchmark Chart
                BenchmarkChart
                    .tag(2)
                    .padding(8)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: UIScreen.main.bounds.width / 1.05)
            .background(cardBackgroundColor.opacity(0.3))
            .cornerRadius(cardCornerRadius)
            .shadow(radius: cardShadow ? 8 : 0)
        }
    }
    
    //MARK: - SECTOR BREAKDOWN CHART
    @ViewBuilder
    private var SectorChart: some View {
        SLSectorBreakdownChart(
            viewModel,
            chartHeader: sectorChartHeader,
            //                    height: height,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            font: font,
            fontColor: fontColor,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            detailFont: sectorDetailFont,
            detailFontColor: sectorDetailFontColor
        )
    }
    
    //MARK: - PROJECTIONS CHART
    @ViewBuilder
    private var ProjectionsChart: some View {
        SLProjectionsChart(
            viewModel,
            chartHeader: projectionsChartHeader,
            height: height,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            chartForegroundColor: chartForegroundColor,
            chartForegroundBorderColor: chartForegroundBorderColor,
            font: font,
            fontColor: fontColor,
            headerFont: headerFont,
            headerFontColor: headerFontColor
        )
    }
    
    //MARK: - BENCHMARKS CHART
    @ViewBuilder
    private var BenchmarkChart: some View {
        Text("Benchmark Coming Soon!")
    }
}
