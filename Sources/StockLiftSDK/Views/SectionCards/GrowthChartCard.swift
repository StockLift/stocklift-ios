//
//  eGrowthChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/21/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct GrowthChartCard: View {
    @StateObject private var growthChartVM = GrowthChartViewModel()
    
    public init() { }
    public var body: some View {
        VStack {
            Text("Portfolio Growth Projections")
                .appFontRegular()
                .padding(.top)
            
            if !growthChartVM.growthChartEntries.isEmpty {
                Spacer()
                LineChart(chartData: growthChartVM.growthChartEntries, dateType: .all)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .padding(.bottom, 28)
                    .padding(.top)
            } else {
                LinkAccountView(plaidError: plaidError, getPortfolio: getPortfolio)
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom)
            }
            Spacer()
        }
        .makeCardLayer()
    }
    
    private func plaidError() {
        growthChartVM.handleAlert(err: .duplicateAccount, codeSheet: "Onboard Porfolio") { }
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}


//struct eGrowthChartCard_Previews: PreviewProvider {
//    static var previews: some View {
//        eGrowthChartCard()
//    }
//}
