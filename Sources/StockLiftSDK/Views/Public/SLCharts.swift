//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

public enum SLChartType: Int, CaseIterable, Identifiable {
    public var id: Self { self }
    case sector
    case benchmark
    case projections
    case geoDiversification
    case topHoldings
    case portfolioSummary
    
    var tag: Int { self.rawValue }
}

@available(iOS 16.0, *)
public struct SLCharts: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var showDisclaimer: Bool = false
    
    //MARK: - PROPERTIES
    /// CHART Type to show
    var chartViews: [SLChartType]
    // Header
    var projectionsChartHeader: String
    var benchmarkChartHeader: String
    var sectorChartHeader: String
    var geoDiversificationChartHeader: String
    var topHoldingsChartHeader: String
    var portfolioSummaryChartHeader: String
    
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
    var subHeaderFont: Font
    var subHeaderFontColor: Color
    var sectorDetailFont: Font
    var sectorDetailFontColor: Color
    var sp500Colors: [Color] // Benchmark Chart
    var portfolioColors: [Color] // Benchmark Chart
    
    // Card Background
    var cardBackgroundColor: Color
    var cardCornerRadius: CGFloat
    var cardShadow: Bool
    
    // Score Button
    var scoreButtonColor: Color
    var scoreButtonFontColor: Color
    var scoreButtonFont: Font
    
    // TOP HOLDINGS
    var topHoldingsButtonColor: Color
    
    //MARK: - INIT
    public init(
        _ views: [SLChartType] = SLChartType.allCases,
        // Chart Headers
        projectionsChartHeader: String = "Portfolio Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. SP 500",
        sectorChartHeader: String = "Diversification by Sector",
        geoDiversificationChartHeader: String = "Geo Diversification",
        topHoldingsChartHeader: String = "Top Holdings",
        portfolioSummaryChartHeader: String = "Portfolio Net Summary",
        
        // Link Account View
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .primary,
        linkAccountBackgroundColor: Color = Color(UIColor.systemBackground),
        linkAccountBorderColor: Color = .primary,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .primary,
        
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
        subHeaderFont: Font = .caption,
        subHeaderFontColor: Color = .primary,
        sectorDetailFont: Font = .caption2,
        sectorDetailFontColor: Color = .primary,
        sp500Colors: [Color] = [.yellow, .yellow.opacity(0.3)],
        portfolioColors: [Color] = [.blue, .blue.opacity(0.3)],
        
        // Card
        cardBackgroundColor: Color = Color(UIColor.tertiaryLabel),
        cardCornerRadius: CGFloat = 14,
        cardShadow: Bool = true,
        
        // Portfolio Summary Score Button
        scoreButtonColor: Color = .blue,
        scoreButtonFontColor: Color = .white,
        scoreButtonFont: Font = .caption,
        
        // TOP HOLDINGS
        topHoldingsButtonColor: Color = .blue
        
    ) {
        self.chartViews = views
        self.projectionsChartHeader = projectionsChartHeader
        self.benchmarkChartHeader = benchmarkChartHeader
        self.sectorChartHeader = sectorChartHeader
        self.geoDiversificationChartHeader = geoDiversificationChartHeader
        self.topHoldingsChartHeader = topHoldingsChartHeader
        self.portfolioSummaryChartHeader = portfolioSummaryChartHeader
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
        self.subHeaderFont = subHeaderFont
        self.subHeaderFontColor = subHeaderFontColor
        self.sp500Colors = sp500Colors
        self.portfolioColors = portfolioColors
        self.cardBackgroundColor = cardBackgroundColor
        self.cardCornerRadius = cardCornerRadius
        self.cardShadow = cardShadow
        self.sectorDetailFont = sectorDetailFont
        self.sectorDetailFontColor = sectorDetailFontColor
        self.scoreButtonColor = scoreButtonColor
        self.scoreButtonFontColor = scoreButtonFontColor
        self.scoreButtonFont = scoreButtonFont
        self.topHoldingsButtonColor = topHoldingsButtonColor
    }
    
    //MARK: - BODY
    public var body: some View {
        TabView {
            if showDisclaimer {
                DisclaimerView(isPresented: $showDisclaimer)
            } else {
                ForEach(chartViews) { view in
                    switch view {
                    case .projections:
                        /// ------------ Projections Chart
                        ProjectionsChartReference
                            .tag(view.tag)
                            .padding(8)
                    case .benchmark:
                        /// ------------ Benchmark Chart
                        BenchmarkChartReference
                            .tag(view.tag)
                            .padding(8)
                    case .sector:
                        /// ------------ Sector Breakdown Chart
                        SectorChartReference
                            .tag(view.tag)
                    case .geoDiversification:
                        /// ------------ GeoDiversification Chart
                        GeoDiversificationChartReference
                            .tag(view.tag)
                            .padding(8)
                    case .topHoldings:
                        /// ------------ Top Holdings Chart
                        TopHoldingsChartReference
                            .tag(view.tag)
                            .padding(8)
                    case .portfolioSummary:
                        /// ------------ Portfolio Summary Chart
                        SummaryChartReference
                            .tag(view.tag)
                            .padding(8)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(maxWidth: UIScreen.main.bounds.width / 1.05)
        .background(cardBackgroundColor.opacity(0.3))
        .cornerRadius(cardCornerRadius)
        .shadow(radius: cardShadow ? 8 : 0)
        .onAppear { viewModel.initView(types: chartViews) }
    }
    
    
    private func plaidError() {
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
    
    //MARK: - SECTOR BREAKDOWN CHART
    @ViewBuilder
    private var SectorChartReference: some View {
        SectorBreakdownChart(
            viewModel,
            showDisclaimer: $showDisclaimer,
            chartHeader: sectorChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            detailFont: sectorDetailFont,
            detailFontColor: sectorDetailFontColor,
            subHeaderFont: subHeaderFont,
            subHeaderFontColor: subHeaderFontColor
        )
    }
    
    //MARK: - PROJECTIONS CHART
    @ViewBuilder
    private var ProjectionsChartReference: some View {
        ProjectionsChart(
            viewModel,
            showDisclaimer: $showDisclaimer,
            chartHeader: projectionsChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio,
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
            showDisclaimer: $showDisclaimer,
            chartHeader: benchmarkChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio,
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
            showDisclaimer: $showDisclaimer,
            chartHeader: geoDiversificationChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio
        )
    }
    
    //MARK: - TOP HOLDINGS CHART
    @ViewBuilder
    private var TopHoldingsChartReference: some View {
        TopHoldingsChart(
            viewModel,
            showDisclaimer: $showDisclaimer,
            chartHeader: topHoldingsChartHeader,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            subHeaderFont: subHeaderFont,
            subHeaderFontColor: subHeaderFontColor,
            buttonColor: topHoldingsButtonColor
        )
    }
    
    // MARK: - PORTFOLIO SUMMARY CHART
    @ViewBuilder
    private var SummaryChartReference: some View {
        PortfolioSummaryChart(
            viewModel,
            showDisclaimer: $showDisclaimer,
//            showNullDataAlert: !viewModel.hasCostBasis,
            chartHeader: portfolioSummaryChartHeader,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            scoreButtonColor: scoreButtonColor,
            scoreButtonFontColor: scoreButtonFontColor,
            scoreButtonFont: scoreButtonFont,
            linkAccountHeader: linkAccountHeader,
            linkAccountForegroundColor: linkAccountForegroundColor,
            linkAccountBackgroundColor:  linkAccountBackgroundColor,
            linkAccountBorderColor: linkAccountBorderColor,
            linkAccountConnectSize: linkAccountConnectSize,
            linkAccountFont: linkAccountFont,
            linkAccountFontColor: linkAccountFontColor,
            plaidError: plaidError,
            getPortfolio: getPortfolio
        )
    }
}


