//
//  eGrowthChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/21/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct GrowthChartCard: View {
    @ObservedObject var portfolioVM: PortfolioViewModel
    @Binding var showAddAsset: Bool
    @State private var selected = ""
    
    var body: some View {
        VStack {
            Text("Portfolio Growth Projections")
                .appFontRegular()
                .padding(.top)
            
            if portfolioVM.hasAccountConnected {
                Spacer()
                LineChart(chartdata: portfolioVM.growthChartEntries, dateType: .all)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .padding(.bottom, 28)
                    .padding(.top)
            } else {
                LinkAccountView(portfolioVM: portfolioVM, plaidError: plaidError)
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom)
            }
            Spacer()
        }
        .makeCardLayer()
    }
    
    private func plaidError() {
        portfolioVM.handleAlert(err: .duplicateAccount, codeSheet: "Onboard Porfolio") { }
    }
}


//struct eGrowthChartCard_Previews: PreviewProvider {
//    static var previews: some View {
//        eGrowthChartCard()
//    }
//}
