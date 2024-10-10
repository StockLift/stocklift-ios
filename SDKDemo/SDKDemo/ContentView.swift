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
            Divider()
            GrowthChartCard()
            Divider()
            GrowthChartCard(linkAccountForegroundColor: .red, linkAccountBackgroundColor: .blue)
            Divider()
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//        .preferredColorScheme(.dark)
//}
