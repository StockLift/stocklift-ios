//
//  TopHoldingsPortfolioView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/30/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct TopHoldingsPortfolioView: View {
    @Binding var showDisclaimer: Bool
    @State var topHoldings: [TopHoldingAsset]
    let totalNetValue: Decimal
    let hasCostBasis: Bool
    @Binding var urls: [String: URL]
    
    // ---- PROPERTIES
    let chartHeader: String
    let headerFont: Font
    let headerFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    let buttonColor: Color
    let buttonFontColor: Color
    let buttonFont: Font
    let assetDefaultColor: Color
    let gainColor: Color
    let lossColor: Color
    let symbolFont: Font  // main symbol and rank //TODO: set properties
    let symbolFontColor: Color
    let nameFont: Font  // name of asset
    let nameFontColor: Color
    let totalPercentColor: Color 
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color 
    
    @State private var showDetails: Bool = false
    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    @State private var sortViewState: SortTopHoldingType = .weight
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Top Holdings")
                .font(headerFont)
                .foregroundColor(headerFontColor)
                .underline(color: headerFontColor)
                .overlay(alignment: .trailing) {
                    DisclaimerImage(showDisclaimer: $showDisclaimer, headerFontColor: headerFontColor)
                }
                .padding(.bottom, 12)
            
            TopHoldingsSortButton(sortViewState: $sortViewState,
                                  fontColor: buttonFontColor,
                                  buttonColor: buttonColor,
                                  buttonFont: buttonFont)
            
            ScrollView {
                ForEach(topHoldings.prefix(10)) { holding in
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
                        fontColor: buttonFontColor,
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
            .setScrollBorderShading()
            
            Text("See All")
                .font(subHeaderFont)
                .foregroundColor(subHeaderFontColor)
                .padding(.vertical, 8)
                .onTapGesture {
                    self.showDetails.toggle()
                }
            
        }
        .popover(isPresented: $showDetails, content: {
            TopHoldingsPortfolioViewAll(
                topHoldings: topHoldings,
                totalNetValue: totalNetValue,
                hasCostBasis: hasCostBasis,
                showUpdateCostBasis: $showUpdateCostBasis,
                urls: $urls,
                fontColor: buttonFontColor,
                buttonColor: buttonColor,
                buttonFont: buttonFont,
                assetDefaultColor: assetDefaultColor,
                gainColor: gainColor,
                lossColor: lossColor,
                symbolFont: symbolFont,
                symbolFontColor: symbolFontColor,
                nameFont: nameFont,
                nameFontColor: nameFontColor,
                totalPercentColor: totalPercentColor,
                assetDetailsHeaderFont: assetDetailsHeaderFont,
                assetDetailsBodyFont: assetDetailsBodyFont,
                assetDetailsHighlightColor: assetDetailsHighlightColor
            )
        })
//        .overlay(alignment: .center) {
//            if showUpdateCostBasis.0 {
//                EditCostBasisView(updateCostBasisAction: updateCostBasisAction,
//                                  showUpdateCostBasis: $showUpdateCostBasis)
//            }
//        }
        .padding(4)
        .onChange(of: sortViewState, perform: { _ in
            toggle(sortViewState)
        })
        .onAppear {
            self.topHoldings = PortfolioViewModel.setTopHoldings(topHoldings.map {$0.holding}, type: sortViewState)
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
    
    //    private func updateCostBasisAction(_ symbol: String, value: Float) {
    //        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    //    }
}






