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

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    let views = [
          "Projections Chart",
          "Sector Chart",
      ]
    
    var body: some View {
//        GrowthProjectionsChart()
        
        NavigationStack {
            List(views, id: \.self) { view in
                NavigationLink {
                    DemoGrowthProjectionsChart()
                } label: {
                    VStack {
                        Text(view)
                            .font(.headline)
                            .padding(.bottom, 6)
                        GrowthProjectionsChart()
                            .padding(2)
                            .border(Color.black)
                    }
                }
            }
            .navigationTitle("Select a Chart")
        }

    }
}



struct DemoGrowthProjectionsChart: View {
    
    let data = (1...5)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { _ in
                    GrowthProjectionsChart(
                        HelperClass.randomTitle(),
                        height: 200,
                        linkAccountForegroundColor: HelperClass.randomColor(),
                        linkAccountBackgroundColor:  HelperClass.randomColor(),
                        linkAccountHeader: HelperClass.randomConnectAccountTitle()
                    )
                }
            }
            .padding(4)
        }
    }
}

