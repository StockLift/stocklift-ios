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
    @State var topHoldings: [TopHoldingAsset]
    let totalNetValue: Decimal
    let hasCostBasis: Bool
    
    let chartHeader: String
    let headerFont: Font
    let headerFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    let buttonColor: Color
    
    @State private var showDetails: Bool = false
    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    
    @State private var sortViewState: SortTopHoldingType = .weight
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Top Holdings")
                .font(headerFont)
                .foregroundColor(headerFontColor)
                .underline(color: headerFontColor)
                .padding(.bottom)
            
            TopHoldingsSortButton(sortViewState: $sortViewState, fontColor: headerFontColor, buttonColor: buttonColor)
            
            ScrollView {
                ForEach(topHoldings.prefix(10)) { holding in
                    TopHoldingsPortfolioCell(asset: holding.holding,
                                             rank: holding.rank,
                                             totalNetValue: totalNetValue,
                                             hasCostBasis: hasCostBasis,
                                             showUpdateCostBasis: $showUpdateCostBasis)
                }
            }
            .frame(maxHeight: 190)
            .setScrollBorderShading()
            
            Text("See All")
                .font(subHeaderFont)
                .foregroundColor(subHeaderFontColor)
                .padding(.horizontal)
                .padding(.vertical)
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
                fontColor: headerFontColor,
                buttonColor: buttonColor
            )
        })
        //        .overlay(alignment: .center) {
        //            if showUpdateCostBasis.0 {
        //                EditCostBasisView(updateCostBasisAction: updateCostBasisAction,
        //                                  showUpdateCostBasis: $showUpdateCostBasis)
        //            }
        //        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 14).stroke(Color.primary, lineWidth: 2)
//        )
        .padding(4)
        //        .makeCardLayer()
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






