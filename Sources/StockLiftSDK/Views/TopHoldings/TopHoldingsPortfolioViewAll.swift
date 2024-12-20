//
//  TopHoldingsPortfolioViewAll.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/30/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct TopHoldingsPortfolioViewAll: View {
    @State var topHoldings: [TopHoldingAsset]
    let totalNetValue: Decimal
    let hasCostBasis: Bool
    @Binding var showUpdateCostBasis: (Bool, String)
    @Binding var urls: [String: URL]
    
    let fontColor: Color
    let buttonColor: Color
    let buttonFont: Font
    let assetDefaultColor: Color
    let gainColor: Color
    let lossColor: Color
    let symbolFont: Font
    let symbolFontColor: Color
    let nameFont: Font
    let nameFontColor: Color 
    let totalPercentColor: Color
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color 
    
    @State private var viewSortType: SortTopHoldingType = .weight
    
    var body: some View {
        ScrollView {
            TopHoldingsSortButton(sortViewState: $viewSortType, fontColor: fontColor, buttonColor: buttonColor, buttonFont: buttonFont)
                .padding(.top)
            
            VStack(spacing: 0) {
                ForEach(topHoldings) { holding in
                    TopHoldingsPortfolioCell(
                        asset: holding.holding,
                        rank: holding.rank,
                        totalNetValue: totalNetValue,
                        hasCostBasis: hasCostBasis,
                        showUpdateCostBasis: $showUpdateCostBasis,
                        url: $urls[holding.holding.symbol ?? "no_symbol"],
                        assetDefaultColor: assetDefaultColor,
                        gainColor: gainColor,
                        lossColor: lossColor,
                        fontColor: fontColor,
                        symbolFont: symbolFont,
                        symbolFontColor: symbolFontColor,
                        nameFont: nameFont,
                        nameFontColor: nameFontColor,
                        totalPercentColor: totalPercentColor,
                        assetDetailsHeaderFont: assetDetailsHeaderFont,
                        assetDetailsBodyFont: assetDetailsBodyFont,
                        assetDetailsHighlightColor: assetDetailsHighlightColor
                    )
                }
            }
        }
        .onChange(of: viewSortType, perform: { _ in
            toggle(viewSortType)
        })
        .onAppear {
            self.topHoldings = PortfolioViewModel.setTopHoldings(topHoldings.map {$0.holding}, type: viewSortType)
        }
    }
    
    private func toggle(_ type: SortTopHoldingType) {
        switch type {
        case .weight:
            self.topHoldings = PortfolioViewModel.setTopHoldings(topHoldings.map {$0.holding}, type: .weight)
        case .percentChange:
            self.topHoldings = PortfolioViewModel.setTopHoldings(topHoldings.map {$0.holding}, type: .percentChange)
        }
    }
}


