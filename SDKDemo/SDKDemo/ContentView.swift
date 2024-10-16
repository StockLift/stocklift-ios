//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

final private class ViewModel: ObservableObject {
    init() {
        let clientHasAccount = SLClient(uuid: "test-123", name: "John Doe", email: "test@test.com")
        StockLiftSDK.client = clientHasAccount
        
//        let clientDoesNotHaveAccount = SLClient(uuid: "test-456", name: "John Doe", email: "test@test.com")
//        StockLiftSDK.client = clientDoesNotHaveAccount
    }
}

private enum ChartType: String, CaseIterable {
    case projections = "Projections Chart"
    case sector = "Sector Chart"
}

@ViewBuilder
private func HeaderView(_ view: ChartType) -> some View {
    VStack {
        Text(view.rawValue)
            .font(.headline)
            .padding(.bottom, 12)
        Divider()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    private let views = ChartType.allCases
    
    var body: some View {
        NavigationStack {
            List(views, id: \.self) { view in
               switch view {
               case .projections:
                   NavigationLink {
                       DemoGrowthProjectionsChart()
                   } label: {
                       VStack {
                           HeaderView(view)
                           // DEMO DEFAULT CHART
                           GrowthProjectionsChart()
                       }
                   }
               case .sector:
                   NavigationLink {
                       Text(view.rawValue)
                   } label: {
                       VStack {
                           HeaderView(view)
                           // DEMO DEFAULT CHART
                       }
                   }
                }
               
            }
            .navigationTitle("Select a Chart Type")
        }
    }
}



struct DemoGrowthProjectionsChart: View {
    let data = (1...5)
    let columns = [
//        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { _ in
                    GrowthProjectionsChart(
                        HelperClass.randomTitle(),
                        height: HelperClass.randomHeight(),
                        linkAccountForegroundColor: HelperClass.randomColor(),
                        linkAccountBackgroundColor:  HelperClass.randomColor(),
                        linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                        chartForegroundColor: HelperClass.randomColor(),
                        chartForegroundBorderColor: HelperClass.randomColor()
                    )
                }
            }
            .padding(4)
        }
    }
}



