//
//  eGrowthChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/21/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct GrowthChartCard: View {
    
    @StateObject private var growthChartVM = GrowthChartViewModel()
    var linkAccountForegroundColor: Color = .white
    var linkAccountBackgroundColor: Color = .yellow
    
    public init() { }
    public init(linkAccountForegroundColor: Color, linkAccountBackgroundColor: Color) {
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
    }
    
    public var body: some View {
        VStack {
            if growthChartVM.growthChartEntries.isEmpty {
                // Link Plaid flow
                LinkAccountView(plaidError: plaidError,
                                getPortfolio: getPortfolio,
                                foregroundColor: linkAccountForegroundColor,
                                backgroundColor: linkAccountBackgroundColor)
                .padding()
                .padding(.bottom)
                .padding(.bottom)
                
            } else {
                Text("Portfolio Growth Projections")
                    .appFontRegular()
                    .padding(.top)
                Spacer()
                LineChart(chartData: growthChartVM.growthChartEntries, dateType: .all)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .padding(.bottom, 28)
                    .padding(.top)
            }
        }
        //        .makeCardLayer()
    }
    
    private func plaidError() {
        growthChartVM.handleAlert(err: .duplicateAccount, codeSheet: "Onboard Portfolio") { }
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}
