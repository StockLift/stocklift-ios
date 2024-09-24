//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

struct ContentView: View {
    var body: some View {
        VStack {
            GrowthChartCard()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
