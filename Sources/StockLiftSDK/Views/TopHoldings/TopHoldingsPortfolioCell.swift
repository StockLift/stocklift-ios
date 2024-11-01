//
//  TopHoldingsPortfolioCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/30/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct TopHoldingsPortfolioCell: View {
    let asset: UserEquity
    let rank: Int
    let totalNetValue: Decimal
    let hasCostBasis: Bool
    @Binding var showUpdateCostBasis: (Bool, String)
    
    // -- PROPERTIES
    let assetDefaultColor: Color
    let gainColor: Color
    let lossColor: Color
    let fontColor: Color 
    
    @State private var showDetails: Bool = false
    @State private var assetImageUrl: URL? = nil
    
    private var currentValue: Float {
        asset.institutionValue ?? 0
    }
    
    private var percentChange: String {
        let change = ((Float(asset.institutionValue ?? 0) / Float(asset.costBasis ?? 0)) - 1) * 100
        return change.clean
    }
    
    private var totalPercent: String {
        let value = (Decimal(Double(asset.institutionValue ?? 0))  / totalNetValue) * 100
        return String(format: "%.2f", Double(truncating: value as NSNumber))
    }
    
    var rankTitle: String {
        if let symbol = asset.symbol {
            return "\(rank). \(symbol)"
        } else {
            return "\(rank). \(asset.type?.title.capitalized ?? "n/a")"
        }
    }
    
    
    var body: some View {
        HStack {
            HStack {
                /// IMAGE
                AssetImageHandler(assetImageUrl: assetImageUrl, asset: asset, size: 34, color: assetDefaultColor, fontColor: fontColor)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        /// SYMBOL & RANK
                        Text(rankTitle)
                            .font(.callout)
                            .layoutPriority(2)
                        /// WEIGHT
                        Text("\(totalPercent)%")
                            .font(.caption)
                            .foregroundColor(.yellow)
//                            .appFontRegular(size: 10, color: .yellow)
                    }
                    
                    if let name = asset.name, !name.isEmpty {
                        /// NAME
                        Text(name)
                            .font(.caption)
//                            .appFontRegular(size: 10)
                            .lineLimit(1)
                    }
                }
                Spacer()
            }
            
            VStack(alignment: .trailing) {
                /// PERFORMANCE
                Text("\(percentChange)%")
                    .font(.caption)
                    .foregroundColor(setColor(percentChange, gainColor: gainColor, lossColor: lossColor))
//                    .appFontRegular(size: 10, color: showView() ? setColor(percentChange) : .appGray)
                /// TOTAL VALUE
                Text(currentValue, format: .currency(code: "USD"))
                    .font(.callout)
            }
            .layoutPriority(1)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .overlay(alignment: .center, content: {
//            if showDetails {
//                PopUpDetailView(asset: asset,
//                                showUpdateCostBasis: $showUpdateCostBasis,
//                                hasCostBasis: hasCostBasis,
//                                hideView: $showDetails)
//            }
        })
        .onTapGesture {
            withAnimation(.easeInOut) {
                showDetails.toggle()
            }
        }
        .onAppear {
            setImage()
        }
    }
    
    /// SHOW or HIDE VIEW
    private func showView() -> Bool {
        switch asset.type {
        case .cash:
            return false
        case .fixedIncome:
            return false
        case .equity:
            return true
        case .mutualFund:
            return true
        case .etf:
            return true
        case .cryptocurrency:
            return false
        case .bonds:
            return false
        case .bond:
            return false
        case .derivative:
            return false
        default:
            return false
        }
    }
    
    /// SET IMAGE
    private func setImage() {
        if let symbol = asset.symbol {
            AssetViewModel.getAssetImage(symbol) { url in
                self.assetImageUrl = url
            }
        }
    }
}






