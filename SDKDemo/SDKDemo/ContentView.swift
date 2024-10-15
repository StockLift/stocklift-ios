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
    
    let data = (1...10)
    
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





