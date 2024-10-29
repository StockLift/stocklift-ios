//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

public enum SLChartAxis {
    case horizontal
    case vertical
}

@available(iOS 16.0, *)
public struct SLCharts: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var showDisclaimer: Bool = false
    
    //MARK: - PROPERTIES
    /// CHARTS to show
    public var chartViews: [SLChartType]
    public var axis: SLChartAxis
    // Header
    public var projectionsChartHeader: String
    public var benchmarkChartHeader: String
    public var sectorChartHeader: String
    public var geoDiversificationChartHeader: String
    public var topHoldingsChartHeader: String
    public var portfolioSummaryChartHeader: String
    
    // Link Account
    public var linkAccountHeader: String
    public var linkAccountForegroundColor: Color
    public var linkAccountBackgroundColor: Color
    public var linkAccountBorderColor: Color
    public var linkAccountConnectSize: CGFloat
    public var linkAccountFont: Font
    public var linkAccountFontColor: Color
    
    // Chart
    public var height: CGFloat
    public var chartForegroundColor: Color
    public var chartForegroundBorderColor: Color
    public var xAxisFont: Font
    public var xAxisFontColor: Color
    public var yAxisFont: Font
    public var yAxisFontColor: Color
    public var headerFont: Font
    public var headerFontColor: Color
    public var subHeaderFont: Font
    public var subHeaderFontColor: Color
    public var sectorDetailFont: Font
    public var sectorDetailFontColor: Color
    public var sp500Colors: [Color] // Benchmark Chart
    public var portfolioColors: [Color] // Benchmark Chart
    public var buttonColor: Color
    public var buttonFontColor: Color
    public var buttonFont: Font
    
    // Card Background
    public var cardBackgroundColor: Color
    public var cardCornerRadius: CGFloat
    public var cardShadow: Bool
    
    // Disclaimer Font
    public var disclaimerTitleFont: Font
    public var disclaimerBodyFont: Font
    
    let chartHeight: CGFloat = UIScreen.main.bounds.width * 0.8
    
    //MARK: - INIT
    public init(
        _ views: [SLChartType] = SLChartType.allCases,
        axis: SLChartAxis = .horizontal,
        // Chart Headers
        projectionsChartHeader: String = "Portfolio Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. SP 500",
        sectorChartHeader: String = "Diversification by Sector",
        geoDiversificationChartHeader: String = "Geo Diversification",
        topHoldingsChartHeader: String = "Top Holdings",
        portfolioSummaryChartHeader: String = "Portfolio Summary",
        
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
        buttonColor: Color = .blue,
        buttonFontColor: Color = .white,
        buttonFont: Font = .caption,
        
        // Card
        cardBackgroundColor: Color = Color(UIColor.tertiaryLabel),
        cardCornerRadius: CGFloat = 14,
        cardShadow: Bool = true,
        
        // Disclaimer Font
        disclaimerTitleFont: Font = .body,
        disclaimerBodyFont: Font = .caption
        
    ) {
        self.chartViews = views
        self.axis = axis
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
        self.buttonColor = buttonColor
        self.buttonFontColor = buttonFontColor
        self.buttonFont = buttonFont
        self.cardBackgroundColor = cardBackgroundColor
        self.cardCornerRadius = cardCornerRadius
        self.cardShadow = cardShadow
        self.sectorDetailFont = sectorDetailFont
        self.sectorDetailFontColor = sectorDetailFontColor
        self.disclaimerBodyFont = disclaimerBodyFont
        self.disclaimerTitleFont = disclaimerTitleFont
    }
    
    //MARK: - BODY
    public var body: some View {
        switch axis {
            //MARK: Horizontal alignment
        case .horizontal:
            TabView {
                if showDisclaimer {
                    DisclaimerView(
                        isPresented: $showDisclaimer,
                        titleFont: disclaimerTitleFont,
                        bodyFont: disclaimerBodyFont
                    )
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
            
            //MARK: Vertical alignment
        case .vertical:
            ScrollView {
                ForEach(chartViews) { view in
                    switch view {
                    case .portfolioSummary:
                        /// ------------ Portfolio Summary Chart
                        SummaryChartReference
                            .frame(height: UIScreen.main.bounds.width * 0.4)
                            .padding(8)
                        SLDivider
                    case .projections:
                        /// ------------ Projections Chart
                        ProjectionsChartReference
                            .frame(height: chartHeight)
                            .padding(8)
                        SLDivider
                    case .benchmark:
                        /// ------------ Benchmark Chart
                        BenchmarkChartReference
                            .frame(height: chartHeight)
                            .padding(8)
                        SLDivider
                    case .sector:
                        /// ------------ Sector Breakdown Chart
                        SectorChartReference
                            .frame(height: chartHeight)
                            .padding(8)
                        SLDivider
                    case .geoDiversification:
                        /// ------------ GeoDiversification Chart
                        GeoDiversificationChartReference
                            .frame(height: chartHeight)
                            .padding(8)
                        SLDivider
                    case .topHoldings:
                        /// ------------ Top Holdings Chart
                        TopHoldingsChartReference
                            .frame(height: chartHeight)
                            .padding(8)
                        SLDivider
                    }
                }
            }
            .onAppear { viewModel.initView(types: chartViews) }
        }
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
            getPortfolio: getPortfolio,
            headerFont: headerFont,
            headerFontColor: headerFontColor,
            subHeaderFont: subHeaderFont,
            subHeaderFontColor: subHeaderFontColor
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
            buttonColor: buttonColor,
            buttonFontColor: buttonFontColor,
            buttonFont: buttonFont
        )
    }
    
    // MARK: - PORTFOLIO SUMMARY CHART
    @ViewBuilder
    private var SummaryChartReference: some View {
        PortfolioSummaryChart(
            viewModel,
            //            showNullDataAlert: !viewModel.hasCostBasis,
            showDisclaimer: $showDisclaimer,
            chartHeader: portfolioSummaryChartHeader,
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
            scoreButtonColor: buttonColor,
            scoreButtonFontColor: buttonFontColor,
            scoreButtonFont: buttonFont,
            bodyFont: subHeaderFont,
            bodyFontColor: subHeaderFontColor
        )
    }
}


