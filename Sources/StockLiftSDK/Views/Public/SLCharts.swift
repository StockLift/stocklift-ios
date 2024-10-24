//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

public enum SLChartType: String, CaseIterable, Identifiable {
    public var id: Self { self }
    case all = "SLCharts"
    case projections = "SLProjectionsChart"
    case sector = "SLSectorBreakdownChart"
    case benchmark = "SLBenchmarkChart"
    case geoDiversification = "SLGeoDiversification Chart"
    case topHoldings = "SLTopHoldingsChart"
}

@available(iOS 16.0, *)
public struct SLCharts: View {
    @StateObject private var viewModel = PortfolioViewModel()
    //MARK: - PROPERTIES
    /// CHART Type to show
    var chartType: SLChartType
    // Header
    var projectionsChartHeader: String
    var benchmarkChartHeader: String
    var sectorChartHeader: String
    var geoDiversificationChartHeader: String
    var topHoldingsChartHeader: String
    
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
    var xAxisFont: Font
    var xAxisFontColor: Color
    var yAxisFont: Font
    var yAxisFontColor: Color
    var headerFont: Font
    var headerFontColor: Color
    var sectorDetailFont: Font
    var sectorDetailFontColor: Color
    var sp500Colors: [Color]
    var portfolioColors: [Color]
    
    // Card Background
    var cardBackgroundColor: Color
    var cardCornerRadius: CGFloat
    var cardShadow: Bool
    
    //MARK: - INIT
    public init(
        _ chartViewType: SLChartType = .all,
        projectionsChartHeader: String = "Portfolio Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. SP 500",
        sectorChartHeader: String = "Diversification by Sector",
        geoDiversificationChartHeader: String = "Geo Diversification",
        topHoldingsChartHeader: String = "Top Holdings",
        
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
        xAxisFont: Font = .caption2,
        xAxisFontColor: Color = .secondary,
        yAxisFont: Font = .caption2,
        yAxisFontColor: Color = .primary,
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        sectorDetailFont: Font = .caption2,
        sectorDetailFontColor: Color = .primary,
        sp500Colors: [Color] = [.yellow, .yellow.opacity(0.3)],
        portfolioColors: [Color] = [.blue, .blue.opacity(0.3)],
        
        // Card
        cardBackgroundColor: Color = .gray.opacity(0.3),
        cardCornerRadius: CGFloat = 14,
        cardShadow: Bool = true
    ) {
        self.chartType = chartViewType
        self.projectionsChartHeader = projectionsChartHeader
        self.benchmarkChartHeader = benchmarkChartHeader
        self.sectorChartHeader = sectorChartHeader
        self.geoDiversificationChartHeader = geoDiversificationChartHeader
        self.topHoldingsChartHeader = topHoldingsChartHeader
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
        self.xAxisFont = xAxisFont
        self.xAxisFontColor = xAxisFontColor
        self.yAxisFont = yAxisFont
        self.yAxisFontColor = yAxisFontColor
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.sp500Colors = sp500Colors
        self.portfolioColors = portfolioColors
        self.cardBackgroundColor = cardBackgroundColor
        self.cardCornerRadius = cardCornerRadius
        self.cardShadow = cardShadow
        self.sectorDetailFont = sectorDetailFont
        self.sectorDetailFontColor = sectorDetailFontColor
    }
    
    //MARK: - BODY
    public var body: some View {
        switch chartType {
        case .projections:
            /// ------------ Projections Chart
            ProjectionsChartReference
        case .benchmark:
            /// ------------ Benchmark Chart
            BenchmarkChartReference
        case .sector:
            /// ------------ Sector Breakdown Chart
            SectorChartReference
        case .geoDiversification:
            /// ------------ GeoDiversification Chart
            GeoDiversificationChartReference
        case .topHoldings:
            /// ------------ Top Holdings Chart
            TopHoldingsChartReference
        case .all:
            TabView {
                /// ------------ Sector Breakdown Chart
                SectorChartReference
                    .tag(0)
                /// ------------ Benchmark Chart
                BenchmarkChartReference
                    .tag(1)
                    .padding(8)
                /// ------------ Projections Chart
                ProjectionsChartReference
                    .tag(2)
                    .padding(8)
                /// ------------ Geo Diversification Chart
                GeoDiversificationChartReference
                    .tag(3)
                    .padding(8)
                /// ------------ Top Holdings Chart
                TopHoldingsChartReference
                    .tag(4)
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
    private var SectorChartReference: some View {
        SectorBreakdownChart(
            viewModel,
            chartHeader: sectorChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            detailFont: sectorDetailFont,
            detailFontColor: sectorDetailFontColor
        )
    }
    
    //MARK: - PROJECTIONS CHART
    @ViewBuilder
    private var ProjectionsChartReference: some View {
        ProjectionsChart(
            viewModel,
            chartHeader: projectionsChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            height: height,
            chartForegroundColor: chartForegroundColor,
            chartForegroundBorderColor: chartForegroundBorderColor,
            xAxisFont: xAxisFont,
            xAxisFontColor: xAxisFontColor,
            yAxisFont: yAxisFont,
            yAxisFontColor: yAxisFontColor,
            headerFont: headerFont,
            headerFontColor: headerFontColor
        )
    }
    
    //MARK: - BENCHMARKS CHART
    @ViewBuilder
    private var BenchmarkChartReference: some View {
        BenchmarkChart(
            viewModel,
            chartHeader: benchmarkChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            height: height,
            sp500Colors: sp500Colors,
            portfolioColors: portfolioColors,
            xAxisFont: xAxisFont,
            xAxisFontColor: xAxisFontColor,
            yAxisFont: yAxisFont,
            yAxisFontColor: yAxisFontColor,
            headerFont: headerFont,
            headerFontColor: headerFontColor
        )
    }
    
    //MARK: - GEO DIVERSIFICATION CHART
    @ViewBuilder
    private var GeoDiversificationChartReference: some View {
        GeoDiversificationChart(
            viewModel,
            chartHeader: geoDiversificationChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor
        )
    }
    
    //MARK: - TOP HOLDINGS CHART
    @ViewBuilder
    private var TopHoldingsChartReference: some View {
        TopHoldingsChart(
            viewModel,
            chartHeader: topHoldingsChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor
        )
    }
}


