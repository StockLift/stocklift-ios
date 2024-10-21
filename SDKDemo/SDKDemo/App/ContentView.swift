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
    
    private let views = ChartType.allCases
    @State private var viewState: ViewState = .charts
    private var toggleTitle: String { isDarkMode ? "Light Mode" : "Dark Mode" }
    
    private enum ChartType: String, CaseIterable, Identifiable {
        public var id: Self { self }
        case projections = "Projections Chart"
        case sector = "Sector Chart"
    }
    
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
                .underline(color: .purple)
                .onTapGesture {
                    toggleView()
                }
            switch viewState {
            case .login:
                DemoLoginView(login: login)
            case .charts:
                Toggle(toggleTitle, isOn: $isDarkMode)
                    .padding(.horizontal)
                    .tint(.gray)
                SLCharts(.all)
//                    .border(.black)
                NavigationStack {
                    ScrollView {
                        VStack {
                            ForEach(views) { view in
                                switch view {
                                    // MARK: - Projections Chart
                                case .projections:
                                    NavigationLink {
                                        DemoGrowthProjectionsChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
//                                            SLProjectionsChart()
                                        }
                                    }
                                    // MARK: - Sector Chart
                                case .sector:
                                    NavigationLink {
                                        DemoSectorBreakdownChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
//                                            SLSectorBreakdownChart(linkAccountBackgroundColor: .purple, linkAccountFontColor: .white, fontColor: .black)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .navigationTitle("Select a Chart Type")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    private func HeaderView<T:View>(_ view: ChartType, @ViewBuilder content: () -> T) -> some View {
        VStack {
            Text(view.rawValue)
                .font(.headline)
                .padding(.bottom, 12)
            content()
            Divider().overlay(Color.white)
        }
        .padding(.bottom, 12)
    }
    
    private func login(_ id: String) {
        let client: SLClient = .init(uuid: id, name: "TEST-\(id)", email: "test-\(id)@test.com")
        StockLiftSDK.client = client
        toggleView()
    }
    
    private func toggleView() {
        switch viewState {
        case .login:
            viewState = .charts
        case .charts:
            viewState = .login
        }
    }
}


//MARK: Growth Projections Chart Demo
fileprivate struct DemoGrowthProjectionsChart: View {
    var body: some View {
        TemplateDemoView {
            SLProjectionsChart(
                HelperClass.randomTitle(),
                height: HelperClass.randomHeight(),
                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                linkAccountForegroundColor: HelperClass.randomColor(),
                linkAccountBackgroundColor:  HelperClass.randomColor(),
                chartForegroundColor: HelperClass.randomColor(),
                chartForegroundBorderColor: HelperClass.randomColor(),
                font: HelperClass.randomSmFont(),
                fontColor: HelperClass.randomColor(),
                headerFont: HelperClass.randomLgFont(),
                headerFontColor: HelperClass.randomColor()
            )
            .padding(CGFloat(Int.random(in: 4...25)))
        }
    }
}

//MARK: Sector Breakdown Chart Demo
fileprivate struct DemoSectorBreakdownChart: View {
    var body: some View {
        TemplateDemoView {
            SLSectorBreakdownChart(
                HelperClass.randomTitle(),
                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                linkAccountForegroundColor: HelperClass.randomColor(),
                linkAccountBackgroundColor: HelperClass.randomColor(),
                linkAccountBorderColor: HelperClass.randomColor(),
                font: HelperClass.randomSmFont(),
                fontColor: HelperClass.randomColor(),
                headerFont: HelperClass.randomLgFont(),
                headerFontColor: HelperClass.randomColor()
            )
            .frame(height: UIScreen.main.bounds.width)
        }
    }
}



