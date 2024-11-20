//
//  SLCharts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct SLCharts<LinkAccountButtonContent: View>: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var selectedTab: Int = 0
    @State private var showDisclaimer: Bool = false
    
    //MARK: - PROPERTIES
    /// CHARTS to show
    private var chartViews: [SLChartType]
    // Vertical or Horizontal
    private var axis: SLChartAxis
    // Vertical Alignment Chart Heights
    private var verticalChartHeights: CGFloat
    
    // Header Text
    private var projectionsChartHeader: String
    private var benchmarkChartHeader: String
    private var sectorChartHeader: String
    private var geoDiversificationChartHeader: String
    private var topHoldingsChartHeader: String
    private var portfolioSummaryChartHeader: String
    
    // Link Account Details
    private var linkAccountHeader: String
    private var linkAccountForegroundColor: Color
    private var linkAccountBackgroundColor: Color
    private var linkAccountBorderColor: Color
    private var linkAccountConnectSize: CGFloat
    private var linkAccountFont: Font
    private var linkAccountFontColor: Color
    private var linkAccountButtonFont: Font
    private var linkAccountButtonColor: Color
    private var linkAccountButtonFontColor: Color
    private var linkAccountButtonText: String
    
    // Chart Details
    private var gainColor: Color
    private let lossColor: Color
    private var height: CGFloat
    private var chartForegroundColor: Color
    private var chartForegroundBorderColor: Color
    private var xAxisFont: Font
    private var xAxisFontColor: Color
    private var yAxisFont: Font
    private var yAxisFontColor: Color
    private var headerFont: Font
    private var headerFontColor: Color
    private var subHeaderFont: Font
    private var subHeaderFontColor: Color
    private var sectorDetailFont: Font
    private var sectorDetailFontColor: Color
    private var sp500Colors: [Color] // Benchmark Chart
    private var portfolioColors: [Color] // Benchmark Chart
    private var buttonColor: Color
    private var buttonFontColor: Color
    private var buttonFont: Font
    
    // Legend
    private var legendFont: Font
    private var legendTextColor: Color

    // Asset Details
    private var sectorHeaderFont: Font // Asset Details //TODO: - rename
    private var sectorHeaderFontColor: Color // Asset Details //TODO: - rename
    private var sectorSubHeaderFont: Font // Asset Details //TODO: - rename
    private var sectorSubHeaderFontColor: Color // Asset Details //TODO: - rename
    private var assetDefaultColor: Color // Asset Details //TODO: - rename
    private var symbolFont: Font // Asset Details Pop up //TODO: - rename
    private var symbolFontColor: Color // Asset Details Pop up //TODO: - rename
    private var nameFont: Font // Asset Details Pop up //TODO: - rename
    private var nameFontColor: Color // Asset Details Pop up //TODO: - rename
    
    // Pop up Asset Details
    private var assetDetailsHeaderFont: Font
    private var assetDetailsBodyFont: Font
    private var assetDetailsHighlightColor: Color
    private var assetDetailsTotalPercentColor: Color
    
    // Card Background
    private var cardBackgroundColor: Color
    private var cardCornerRadius: CGFloat
    private var cardShadow: Bool
    
    // Disclaimer Font
    private var disclaimerTitleFont: Font
    private var disclaimerBodyFont: Font
    
    private var linkViewButton: LinkAccountButtonContent
    
    //MARK: - INIT
    public init(
        _ views: [SLChartType] = SLChartType.allCases,
        axis: SLChartAxis = .horizontal,
        verticalChartHeights: CGFloat = UIScreen.main.bounds.width * 0.8,
        // Chart Headers
        projectionsChartHeader: String = "Growth Projections",
        benchmarkChartHeader: String = "My Portfolio vs. S&P 500",
        sectorChartHeader: String = "Sector Diversification",
        geoDiversificationChartHeader: String = "Geography Diversification",
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
        assetDetailsTotalPercentColor: Color = .yellow,
        legendFont: Font = .caption2, // caption2
        legendTextColor: Color = .primary, // primary
        @ViewBuilder linkViewButton: @escaping () -> LinkAccountButtonContent = { LinkAccountButton() }
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
        self.legendFont = legendFont
        self.legendTextColor = legendTextColor
        self.linkViewButton = linkViewButton()
    }
    
    public var body: some View {
        switch axis {
            //MARK: Horizontal alignment
        case .horizontal:
            HorizontalViewReference
            //MARK: Vertical alignment
        case .vertical:
            VerticalViewReference
        }
    }
}


//MARK: AXIS VIEWS
@available(iOS 16.0, *)
extension SLCharts {
    
    //MARK: ** HORIZONTAL VIEW REFERENCE **
    @ViewBuilder
    private var HorizontalViewReference: some View {
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

            // TAB SELECTOR (back or next)
            HStack {
                TabSelector(imageName: ImageKeys.arrowLeftCircle,
                            action: backTab,
                            selectable: firstSelectable)
                Spacer()
                OpenLinkButton(getPortfolio: getPortfolio, errorHandler: plaidError) {
                    linkViewButton
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
        .onAppear { getPortfolio() }
    }
    
    //MARK: ** VERTICAL VIEW REFERENCE **
    @ViewBuilder
    private var VerticalViewReference: some View {
        ScrollView {
            if showDisclaimer {
                DisclaimerView(
                    isPresented: $showDisclaimer,
                    titleFont: disclaimerTitleFont,
                    bodyFont: disclaimerBodyFont
                )
            } else {
                if !viewModel.hasAccountConnected {
                    // Link Plaid flow
                    if viewModel.isLoadingBenchmarkData ||
                        viewModel.isLoadingPortfolioData ||
                        viewModel.isLoadingGeoDiversificationData {
                        ProgressView()
                            .padding()
                    }  else {
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
        .onDisappear {
            UserDefaults.standard.removeObject(forKey: UserKeys.linkToken)
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
            headerFontColor: headerFontColor,
            legendFont: legendFont,
            legendTextColor: legendTextColor
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
            bodyFontColor: subHeaderFontColor,
            linkViewButton: {linkViewButton}
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
        if let value = getViewState()?.rawValue {
            self.selectedTab = value
        }
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
                self.setViewState(view)
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
                self.setViewState(view)
                self.selectedTab = view.rawValue
                HapticTap.light()
            }
        }
    }
    
    // Set selected view state
    private func setViewState(_ view: SLChartType) {
        UserDefaults.standard.set(view.rawValue, forKey: UserKeys.viewState)
    }
    
    // Get last selected view state
    private func getViewState() -> SLChartType? {
        let value = UserDefaults.standard.value(forKey: UserKeys.viewState) as? Int
        if let value = value {
            return SLChartType(rawValue: value)
        }
        return nil
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
