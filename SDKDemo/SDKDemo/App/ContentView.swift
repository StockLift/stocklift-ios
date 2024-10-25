//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

struct ContentView: View {
    @Binding var isDarkMode: Bool
    private let views = SLChartType.allCases
    @State private var viewState: ViewState = .charts
    @State private var showTopView: Bool = true
    private var toggleTitle: String { isDarkMode ? "Light Mode" : "Dark Mode" }
    private var showTopViewTitle: String { showTopView ? "Hide Top View" : "Show Top View" }
    
    private enum ViewState {
        case login, charts
        var title: String {
            switch self {
            case .login:
                return "Login"
            case .charts:
                return "Charts"
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(viewState.title)
                .font(.title)
                .onTapGesture { toggleView() }
            switch viewState {
            case .login:
                DemoLoginView(login: login)
            case .charts:
                Toggle(toggleTitle, isOn: $isDarkMode)
                    .padding(.horizontal)
                    .tint(.gray)
                //                Toggle(showTopViewTitle, isOn: $showTopView)
                //                    .padding(.horizontal)
                //                    .tint(.gray)
                //                if showTopView {
                //                    SLCharts(.all)
                //                }
                NavigationStack {
                    ScrollView {
                        VStack {
                            ForEach(views) { view in
                                switch view {
                                case .all:
                                    // MARK: - All Charts
                                    NavigationLink {
                                        DemoAllChartsView()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                    
                                case .projections:
                                    // MARK: - Projections Chart
                                    NavigationLink {
                                        DemoGrowthProjectionsChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                case .sector:
                                    // MARK: - Sector Chart
                                    NavigationLink {
                                        DemoSectorBreakdownChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                    
                                case .benchmark:
                                    // MARK: - Benchmark Chart
                                    NavigationLink {
                                        DemoBenchmarkChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                    
                                case .geoDiversification:
                                    // MARK: - GEO DIVERSIFICATION Chart
                                    NavigationLink {
                                        DemoGeoDiversificationChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                case .topHoldings:
                                    // MARK: - TOP HOLDINGS Chart
                                    NavigationLink {
                                        DemoTopHoldingsChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                    
                                case .portfolioSummary:
                                    // MARK: - PORTFOLIO SUMMARY Chart
                                    NavigationLink {
                                        DemoPortfolioSummaryChart()
                                    } label: {
                                        HeaderView(view) { }
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Select a Chart Type")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    // LIST Header View
    private func HeaderView<T:View>(_ view: SLChartType, @ViewBuilder content: () -> T) -> some View {
        VStack {
            Text(view.rawValue)
                .font(.headline)
                .padding(.bottom, 12)
            content()
            Divider().overlay(Color.white)
        }
        .padding(.bottom, 12)
    }
    
    // LOGIN - (create a new test client from uuid)
    private func login(_ id: String) {
        let client: SLClient = .init(uuid: id, name: "TEST-\(id)", email: "test-\(id)@test.com")
        StockLiftSDK.client = client
        toggleView()
    }
    
    // TOGGLE View
    private func toggleView() {
        switch viewState {
        case .login:
            viewState = .charts
        case .charts:
            viewState = .login
        }
    }
}





