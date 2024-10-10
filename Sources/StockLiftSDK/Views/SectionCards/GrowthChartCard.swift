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
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let chartHeader: String
    
    public init(linkAccountForegroundColor: Color = .white,
                linkAccountBackgroundColor: Color = .yellow,
                chartHeader: String = "Portfolio Growth Projections") {
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.chartHeader = chartHeader
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
                Text(chartHeader)
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
        //TODO: -  handle error
    }
    
    private func getPortfolio() {
        //TODO: config get portfolio
    }
}
