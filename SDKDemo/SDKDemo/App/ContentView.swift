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
    @State private var showTopView: Bool = true
    private var toggleTitle: String { isDarkMode ? "Light Mode" : "Dark Mode" }
    private var showTopViewTitle: String { showTopView ? "Hide Top View" : "Show Top View" }
    
    private enum ChartType: String, CaseIterable, Identifiable {
        public var id: Self { self }
        case all = "All Charts"
        case projections = "Projections Chart"
        case sector = "Sector Chart"
        case benchmark = "Benchmark Chart"
        case netWorth = "Net Worth Chart"
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
                Toggle(showTopViewTitle, isOn: $showTopView)
                    .padding(.horizontal)
                    .tint(.gray)
                if showTopView {
                    SLCharts(.all)
                }
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
                                        HeaderView(view) {
                                            SLCharts(.all)
                                        }
                                    }
                                    
                                case .projections:
                                    // MARK: - Projections Chart
                                    NavigationLink {
                                        DemoGrowthProjectionsChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
                                        }
                                    }
                                case .sector:
                                    // MARK: - Sector Chart
                                    NavigationLink {
                                        DemoSectorBreakdownChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
                                        }
                                    }
                                    
                                case .benchmark:
                                    // MARK: - Benchmark Chart
                                    NavigationLink {
                                        DemoBenchmarkChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
                                        }
                                    }
                                    
                                case .netWorth:
                                    // MARK: - Net Worth Chart
                                    NavigationLink {
                                        DemoNetWorthChart()
                                    } label: {
                                        HeaderView(view) {
                                            // DEMO DEFAULT CHART
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
    
    // LIST Header View
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


//MARK: ALL Charts Demo
fileprivate struct DemoAllChartsView: View {
    var body: some View {
        ScrollView {
            VStack {
                SLCharts()
                    .frame(height: 350)
                    .padding()
                    
                    Spacer()
                    Rectangle().fill(Color.gray).frame(height: 35)
                        .overlay {
                            Text("This is a demo of the All Charts configuration.")
                        }
                            
                            
                SLCharts(.all,
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
                         fontColor: HelperClass.randomColor(),
                         headerFontColor: HelperClass.randomColor(),
                         sectorDetailFontColor: HelperClass.randomColor(),
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 350)
                .padding()
                
                Spacer()
                Rectangle().fill(Color.gray).frame(height: 100)
                    .overlay {
                        Text("This is a demo of the All Charts configuration.")
                    }
                SLCharts(.all,
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
                         fontColor: HelperClass.randomColor(),
                         headerFontColor: HelperClass.randomColor(),
                         sectorDetailFontColor: HelperClass.randomColor(),
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 420)
                Spacer()
                Rectangle().fill(Color.gray).frame(height: 60)
                    .overlay {
                        Text("This is a demo of the All Charts configuration.")
                    }
            }
        }
        .navigationBarTitle("All Charts Demo")
    }
}

//MARK: Growth Projections Chart Demo
fileprivate struct DemoGrowthProjectionsChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
//        TemplateDemoView {
//            SLProjectionsChart(
//                chartHeader: HelperClass.randomTitle(),
//                height: HelperClass.randomHeight(),
//                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
//                linkAccountForegroundColor: HelperClass.randomColor(),
//                linkAccountBackgroundColor:  HelperClass.randomColor(),
//                chartForegroundColor: HelperClass.randomColor(),
//                chartForegroundBorderColor: HelperClass.randomColor(),
//                font: HelperClass.randomSmFont(),
//                fontColor: HelperClass.randomColor(),
//                headerFont: HelperClass.randomLgFont(),
//                headerFontColor: HelperClass.randomColor()
//            )
//            .padding(CGFloat(Int.random(in: 4...25)))
//        }
    }
}

//MARK: Sector Breakdown Chart Demo
fileprivate struct DemoSectorBreakdownChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
//        TemplateDemoView {
//            SLSectorBreakdownChart(
//                chartHeader: HelperClass.randomTitle(),
//                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
//                linkAccountForegroundColor: HelperClass.randomColor(),
//                linkAccountBackgroundColor: HelperClass.randomColor(),
//                linkAccountBorderColor: HelperClass.randomColor(),
//                font: HelperClass.randomSmFont(),
//                fontColor: HelperClass.randomColor(),
//                headerFont: HelperClass.randomLgFont(),
//                headerFontColor: HelperClass.randomColor()
//            )
//            .frame(height: UIScreen.main.bounds.width)
//        }
    }
}

//MARK: Benchmark Chart Demo
fileprivate struct DemoBenchmarkChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
    }
}

//MARK: Net Worth Chart Demo
fileprivate struct DemoNetWorthChart: View {
    var body: some View {
        Text("Coming Soon")
            .font(.footnote)
    }
}
