//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

final class ViewModel: ObservableObject {
    init() {
        let client = SLClient(uuid: "test-123", name: "John Doe", email: "test@test.com")
        StockLiftSDK.client = client
    }
}

enum ChartTypes: String, CaseIterable {
    case projections = "Projections Chart"
    case sector = "Sector Chart"
}

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    let views = ChartTypes.allCases
    
    var body: some View {
        NavigationStack {
            List(views, id: \.self) { view in
               switch view {
               case .projections:
                   NavigationLink {
                       DemoGrowthProjectionsChart()
                   } label: {
                       VStack {
                           Text(view.rawValue)
                               .font(.headline)
                               .padding(.bottom, 6)
                           GrowthProjectionsChart()
                               .padding(2)
                               .border(Color.black)
                       }
                   }
               case .sector:
                   NavigationLink {
                       Text(view.rawValue)
                   } label: {
                       VStack {
                           Text(view.rawValue)
                               .font(.headline)
                               .padding(.bottom, 6)
//                           GrowthProjectionsChart()
//                               .padding(2)
//                               .border(Color.black)
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



