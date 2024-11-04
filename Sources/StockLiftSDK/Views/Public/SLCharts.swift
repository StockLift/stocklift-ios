//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct SLCharts: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var selectedTab: Int = 0
    @State private var showDisclaimer: Bool = false
    
    //MARK: - PROPERTIES
    /// CHARTS to show
    public var chartViews: [SLChartType]
    // Vertical or Horizontal
    public var axis: SLChartAxis
    // Vertical Alignment Chart Heights
    public var verticalChartHeights: CGFloat
    
    // Header Text
    public var projectionsChartHeader: String
    public var benchmarkChartHeader: String
    public var sectorChartHeader: String
    public var geoDiversificationChartHeader: String
    public var topHoldingsChartHeader: String
    public var portfolioSummaryChartHeader: String
    
    // Link Account Details
    public var linkAccountHeader: String
    public var linkAccountForegroundColor: Color
    public var linkAccountBackgroundColor: Color
    public var linkAccountBorderColor: Color
    public var linkAccountConnectSize: CGFloat
    public var linkAccountFont: Font
    public var linkAccountFontColor: Color
    public var linkAccountButtonFont: Font
    public var linkAccountButtonColor: Color
    public var linkAccountButtonFontColor: Color
    public var linkAccountButtonText: String
    
    // Chart Details
    public var gainColor: Color
    public let lossColor: Color
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
    
    // Asset Details
    public var sectorHeaderFont: Font // Asset Details //TODO: - rename
    public var sectorHeaderFontColor: Color // Asset Details //TODO: - rename
    public var sectorSubHeaderFont: Font // Asset Details //TODO: - rename
    public var sectorSubHeaderFontColor: Color // Asset Details //TODO: - rename
    public var assetDefaultColor: Color // Asset Details //TODO: - rename
    public var symbolFont: Font // Asset Details Pop up //TODO: - rename
    public var symbolFontColor: Color // Asset Details Pop up //TODO: - rename
    public var nameFont: Font // Asset Details Pop up //TODO: - rename
    public var nameFontColor: Color // Asset Details Pop up //TODO: - rename
    
    // Pop up Asset Details
    public var assetDetailsHeaderFont: Font
    public var assetDetailsBodyFont: Font
    public var assetDetailsHighlightColor: Color
    public var assetDetailsTotalPercentColor: Color
    
    // Card Background
    public var cardBackgroundColor: Color
    public var cardCornerRadius: CGFloat
    public var cardShadow: Bool
    
    // Disclaimer Font
    public var disclaimerTitleFont: Font
    public var disclaimerBodyFont: Font
    
    //MARK: - INIT
    public init(
        _ views: [SLChartType] = SLChartType.allCases,
        axis: SLChartAxis = .horizontal,
        verticalChartHeights: CGFloat = UIScreen.main.bounds.width * 0.8,
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
        linkAccountButtonColor: Color = .blue,
        linkAccountButtonFont: Font = .caption,
        linkAccountButtonFontColor: Color = .white,
        linkAccountButtonText: String = "Link an Account",
        // Charts
        gainColor: Color = .blue,
        lossColor: Color = .red,
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
        sectorHeaderFont: Font = .callout,
        sectorHeaderFontColor: Color = .primary,
        sectorSubHeaderFont: Font = .caption2,
        sectorSubHeaderFontColor: Color = .primary,
        assetDefaultColor: Color = .blue,
        symbolFont: Font = .caption,
        symbolFontColor: Color = .primary,
        nameFont: Font = .caption,
        nameFontColor: Color = .secondary,
        
        // Card
        cardBackgroundColor: Color = Color(UIColor.tertiaryLabel),
        cardCornerRadius: CGFloat = 14,
        cardShadow: Bool = true,
        
        // Disclaimer Font
        disclaimerTitleFont: Font = .body,
        disclaimerBodyFont: Font = .caption,
        assetDetailsHeaderFont: Font = .caption,
        assetDetailsBodyFont: Font = .caption2,
        assetDetailsHighlightColor: Color = .yellow,
        assetDetailsTotalPercentColor: Color = .yellow
    ) {
        self.chartViews = views
        self.axis = axis
        self.verticalChartHeights = verticalChartHeights
        self.projectionsChartHeader = projectionsChartHeader
        self.benchmarkChartHeader = benchmarkChartHeader
        self.sectorChartHeader = sectorChartHeader
        self.geoDiversificationChartHeader = geoDiversificationChartHeader
        self.topHoldingsChartHeader = topHoldingsChartHeader
        self.portfolioSummaryChartHeader = portfolioSummaryChartHeader
        // Link Account
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.linkAccountButtonColor = linkAccountButtonColor
        self.linkAccountButtonFont = linkAccountButtonFont
        self.linkAccountButtonFontColor = linkAccountButtonFontColor
        self.linkAccountButtonText = linkAccountButtonText
        // Chart
        self.gainColor = gainColor
        self.lossColor = lossColor
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
        self.sectorHeaderFont = sectorHeaderFont
        self.sectorHeaderFontColor = sectorHeaderFontColor
        self.sectorSubHeaderFont = sectorSubHeaderFont
        self.sectorSubHeaderFontColor = sectorSubHeaderFontColor
        self.assetDefaultColor = assetDefaultColor
        self.symbolFont = symbolFont
        self.symbolFontColor = symbolFontColor
        self.nameFont = nameFont
        self.nameFontColor = nameFontColor
        self.assetDetailsHeaderFont = assetDetailsHeaderFont
        self.assetDetailsBodyFont = assetDetailsBodyFont
        self.assetDetailsHighlightColor = assetDetailsHighlightColor
        self.assetDetailsTotalPercentColor = assetDetailsTotalPercentColor
    }
    
    public var body: some View {
        switch axis {
            //MARK: - Horizontal alignment
        case .horizontal:
            VStack {
                TabView(selection: $selectedTab) {
                    if showDisclaimer {
                        DisclaimerView(
                            isPresented: $showDisclaimer,
                            titleFont: disclaimerTitleFont,
                            bodyFont: disclaimerBodyFont
                        )
                    } else {
                        ForEach(chartViews) { view in
                            switch view {
                            case .projectionsPerformance:
                                /// ------------ Projections Chart
                                ProjectionsChartReference
                                    .tag(view.tag(chartViews))
                                    .padding(8)
                            case .benchmarkPerformance:
                                /// ------------ Benchmark Chart
                                BenchmarkChartReference
                                    .tag(view.tag(chartViews))
                                    .padding(8)
                            case .sectorDiversification:
                                /// ------------ Sector Breakdown Chart
                                SectorChartReference
                                    .tag(view.tag(chartViews))
                            case .geoDiversification:
                                /// ------------ GeoDiversification Chart
                                GeoDiversificationChartReference
                                    .tag(view.tag(chartViews))
                                    .padding(8)
                            case .topHoldings:
                                /// ------------ Top Holdings Chart
                                TopHoldingsChartReference
                                    .tag(view.tag(chartViews))
                                    .padding(8)
                            case .portfolioSummary:
                                /// ------------ Portfolio Summary Chart
                                SummaryChartReference
                                    .tag(view.tag(chartViews))
                                    .padding(8)
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxWidth: UIScreen.main.bounds.width / 1.05)
                .onAppear { getPortfolio() }
                
                // TAB SELECTOR (back or next)
                HStack {
                    TabSelector(imageName: ImageKeys.arrowLeftCircle,
                                action: backTab,
                                selectable: firstSelectable)
                    Spacer()
                    OpenLinkButton(getPortfolio: getPortfolio, errorHandler: plaidError) {
                        LinkAccountButton(
                            linkAccountButtonText: linkAccountButtonText,
                            linkAccountButtonFont: linkAccountButtonFont,
                            linkAccountButtonFontColor: linkAccountButtonFontColor,
                            linkAccountButtonColor: linkAccountButtonColor
                        )
                    }
                    Spacer()
                    TabSelector(imageName: ImageKeys.arrowRightCircle,
                                action: nextTab,
                                selectable: lastSelectable)
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
            .background(cardBackgroundColor.opacity(0.3))
            .cornerRadius(cardCornerRadius)
            .shadow(radius: cardShadow ? 8 : 0)
            
            //MARK: - Vertical alignment
        case .vertical:
            ScrollView {
                if showDisclaimer {
                    DisclaimerView(
                        isPresented: $showDisclaimer,
                        titleFont: disclaimerTitleFont,
                        bodyFont: disclaimerBodyFont
                    )
                } else {
                    if viewModel.isLoading == false && !viewModel.hasAccountConnected {
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
                        /// ------------ Portfolio Summary Chart
                        ForEach(chartViews) { view in
                            switch view {
                            case .portfolioSummary:
                                /// Vertical alignment always shows summary at top
                                SummaryChartReference
                                SLDivider
                            case .projectionsPerformance:
                                /// ------------ Projections Chart
                                ProjectionsChartReference
                                    .frame(height: verticalChartHeights)
                                    .padding(8)
                                SLDivider
                            case .benchmarkPerformance:
                                /// ------------ Benchmark Chart
                                BenchmarkChartReference
                                    .frame(height: verticalChartHeights)
                                    .padding(8)
                                SLDivider
                            case .sectorDiversification:
                                /// ------------ Sector Breakdown Chart
                                SectorChartReference
                                    .frame(height: verticalChartHeights)
                                    .padding(8)
                                SLDivider
                            case .geoDiversification:
                                /// ------------ GeoDiversification Chart
                                GeoDiversificationChartReference
                                    .frame(height: verticalChartHeights)
                                    .padding(8)
                                SLDivider
                            case .topHoldings:
                                /// ------------ Top Holdings Chart
                                TopHoldingsChartReference
                                    .frame(height: verticalChartHeights)
                                    .padding(8)
                                SLDivider
                            }
                        }
                    }
                }
            }
            .onAppear { getPortfolio() }
        }
    }
}

//MARK: CHARTS
@available(iOS 16.0, *)
extension SLCharts {
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
            subHeaderFontColor: subHeaderFontColor,
            gainColor: gainColor,
            lossColor: lossColor,
            sectorHeaderFont: sectorHeaderFont,
            sectorHeaderFontColor: sectorHeaderFontColor,
            sectorSubHeaderFont: sectorSubHeaderFont,
            sectorSubHeaderFontColor: sectorSubHeaderFontColor,
            assetDefaultColor: assetDefaultColor,
            symbolFont: symbolFont,
            nameFont: nameFont,
            assetDetailsHeaderFont: assetDetailsHeaderFont,
            assetDetailsBodyFont: assetDetailsBodyFont,
            assetDetailsHighlightColor: assetDetailsHighlightColor
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
            subHeaderFontColor: subHeaderFontColor,
            gainColor: gainColor,
            lossColor: lossColor,
            assetDefaultColor: assetDefaultColor,
            symbolFont: symbolFont,
            symbolFontColor: symbolFontColor,
            nameFont: nameFont,
            assetDetailsHeaderFont: assetDetailsHeaderFont,
            assetDetailsBodyFont: assetDetailsBodyFont,
            assetDetailsHighlightColor: assetDetailsHighlightColor,
            sectorHeaderFont: sectorHeaderFont,
            sectorHeaderFontColor: sectorHeaderFontColor,
            sectorSubHeaderFont: sectorSubHeaderFont,
            sectorSubHeaderFontColor: sectorSubHeaderFontColor
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
            buttonFont: buttonFont,
            assetDefaultColor: assetDefaultColor,
            gainColor: gainColor,
            lossColor: lossColor,
            symbolFont: symbolFont,
            symbolFontColor: symbolFontColor,
            nameFont: nameFont,
            nameFontColor: nameFontColor,
            totalPercentColor: assetDetailsTotalPercentColor,
            assetDetailsHeaderFont: assetDetailsHeaderFont,
            assetDetailsBodyFont: assetDetailsBodyFont,
            assetDetailsHighlightColor: assetDetailsHighlightColor
        )
    }
    
    // MARK: - PORTFOLIO SUMMARY CHART
    @ViewBuilder
    private var SummaryChartReference: some View {
        PortfolioSummaryChart(
            viewModel,
            axis: axis,
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
            linkAccountButtonColor: linkAccountButtonColor,
            linkAccountButtonFont: linkAccountButtonFont,
            linkAccountButtonFontColor: linkAccountButtonFontColor,
            linkAccountButtonText: linkAccountButtonText,
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

//MARK: NETWORK METHODS
@available(iOS 16.0, *)
extension SLCharts {
    // PLAID ERROR
    private func plaidError() {
        //TODO: -  remove
        // this setup will not be using this for now, the backend is handling errors differently then the stocklift app
    }
    
    // GET PORTFOLIO
    private func getPortfolio() {
        viewModel.initView(types: chartViews)
    }
}

//MARK: TAB BAR Item & NAVIGATION METHODS
@available(iOS 16.0, *)
extension SLCharts {
    //MARK: Tab bar next and back selector
    @ViewBuilder
    private func TabSelector(imageName: String, action: @escaping () -> Void, selectable: Bool) -> some View {
        Image(systemName: imageName)
            .font(.title2)
            .foregroundColor(selectable ? Color(UIColor.tertiaryLabel) : .clear)
            .contentShape(Circle())
            .onTapGesture {
                if selectable {
                    action()
                }
            }
    }
    
    // Move to Next Tab
    private func nextTab() {
        let nextIndex = selectedTab + 1
        if nextIndex <= chartViews.count {
            let next = chartViews.index(after: selectedTab)
            let nextView = SLChartType(rawValue: next)
            if let view = nextView {
                self.selectedTab = view.rawValue
                HapticTap.light()
            }
        }
    }
    
    // Move Back a Tab
    private func backTab() {
        let nextIndex = selectedTab - 1
        if nextIndex <= chartViews.count {
            let next = chartViews.index(before: selectedTab)
            let nextView = SLChartType(rawValue: next)
            if let view = nextView {
                self.selectedTab = view.rawValue
                HapticTap.light()
            }
        }
    }
    
    // Last Selectable Tab
    private var lastSelectable: Bool {
        selectedTab != chartViews.last?.tag(chartViews)
    }
    
    // First Selectable Tab
    private var firstSelectable: Bool {
        selectedTab != chartViews.first?.tag(chartViews)
    }
}
