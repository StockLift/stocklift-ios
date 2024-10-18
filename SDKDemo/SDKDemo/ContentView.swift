//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK


fileprivate class ContentViewModel: ObservableObject {
    init() {
        let clientHasAccount = SLClient(uuid: "test-123", name: "John Doe", email: "test@test.com")
        StockLiftSDK.client = clientHasAccount
        
        //        let clientDoesNotHaveAccount = SLClient(uuid: "test-456", name: "John Doe", email: "test@test.com")
        //        StockLiftSDK.client = clientDoesNotHaveAccount
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    private enum ChartType: String, CaseIterable, Identifiable {
        public var id: Self { self }
        case projections = "Projections Chart"
        case sector = "Sector Chart"
    }
    
    private let views = ChartType.allCases
    
    var body: some View {
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
                                    SLProjectionsChart()
                                }
                            }
                            
                            // MARK: - Sector Chart
                        case .sector:
                            NavigationLink {
                                SectorChartCard()
                            } label: {
                                HeaderView(view) {
                                    // DEMO DEFAULT CHART
                                    SectorChartCard()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .navigationTitle("Select a Chart Type")
        }
    }
    
    private func HeaderView<T:View>(_ view: ChartType, @ViewBuilder content: () -> T) -> some View {
        VStack {
            Text(view.rawValue)
                .font(.headline)
                .padding(.bottom, 12)
//                .underline(color: .gray)
            content()
            Divider().overlay(Color.white)
        }
        .padding(.bottom, 12)
    }
}



fileprivate struct DemoGrowthProjectionsChart: View {
    let data = (1...5)
    let columns = [
        //        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { _ in
                    SLProjectionsChart(
                        HelperClass.randomTitle(),
                        height: HelperClass.randomHeight(),
                        linkAccountForegroundColor: HelperClass.randomColor(),
                        linkAccountBackgroundColor:  HelperClass.randomColor(),
                        linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                        chartForegroundColor: HelperClass.randomColor(),
                        chartForegroundBorderColor: HelperClass.randomColor()
                    )
                    .padding(CGFloat(Int.random(in: 4...25)))
                }
            }
        }
    }
}



