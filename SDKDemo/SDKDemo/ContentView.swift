//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

struct ContentView: View {
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
                                    SLProjectionsChart(linkAccountFontColor: .white, fontColor: .black)
                                }
                            }
                            
                            // MARK: - Sector Chart
                        case .sector:
                            NavigationLink {
                                DemoSectorBreakdownChart()
                            } label: {
                                HeaderView(view) {
                                    // DEMO DEFAULT CHART
                                    SLSectorBreakdownChart(linkAccountBackgroundColor: .purple, linkAccountFontColor: .white, fontColor: .black)
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
            content()
            Divider().overlay(Color.white)
        }
        .padding(.bottom, 12)
    }
}


//MARK: Growth Projections Chart Demo
fileprivate struct DemoGrowthProjectionsChart: View {
    let data = (1...5)
    let columns = [
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { _ in
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
        .preferredColorScheme(.dark)
    }
}

//MARK: Sector Breakdown Chart Demo
fileprivate struct DemoSectorBreakdownChart: View {
    let data = (1...5)
    let columns = [
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { _ in
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
                    .padding(CGFloat(Int.random(in: 4...25)))
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}



