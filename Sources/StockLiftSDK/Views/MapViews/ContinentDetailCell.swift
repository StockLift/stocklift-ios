//
//  ContinentDetailCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/9/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContinentDetailCell: View {
    let assetDetails: GeoAssetsData
    
    @Binding var showUpdateCostBasis: (Bool, String)
    @Binding var assetImages: [String: URL]
    @Binding var hasCostBasis: Bool
    
    let gainColor: Color
    let lossColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let fontColor: Color
    let nameFont: Font
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    var continentName: String {
        assetDetails.continent
    }
    
    // percent of investment
    var continentWeight: String {
        let value = assetDetails.continentWeight
        return String(format: "%.2f", Double(truncating: value as NSNumber))
    }
    
    var continentGain: String {
        let value = assetDetails.continentGain
        return String(format: "%.2f", Double(truncating: value as NSNumber))
    }
    
    var totalAmountInvested: String {
        let value = assetDetails.continentTotalValue
        return value.formatted(.currency(code: "USD"))
    }
    
    var dollarGain: String {
        let value = assetDetails.continentDollarGain
        return value.formatted(.currency(code: "USD"))
    }
    
    @State private var isShowing: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text(continentName)
//                    .appFontMedium()
                Spacer()
                Image(systemName: isShowing ? "chevron.down" : "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 12, height: 12)
                
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if continentName != "Uncategorized" {
                            Image(systemName: self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor) == Color.green ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .background(Color.blue)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(continentWeight)%")
//                                .appFontBlack(size: 16)
                                .padding(.vertical, 0)
                            
//                            if continentName != "Uncategorized" {
                                Text("\(setSymbol(continentGain))%")
//                                    .appFontBlack(size: 12, color: self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor))
//                            }
                        }
                    }
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
                
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if continentName != "Uncategorized" {
                            Image(systemName: self.setColor(dollarGain, gainColor: gainColor, lossColor: lossColor) == Color.green ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .background(Color.blue)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(totalAmountInvested)
//                                .appFontBlack(size: 16)
                                .padding(.vertical, 0)
                            
//                            if continentName != "Uncategorized" {
                                Text("\(setSymbol(dollarGain))")
//                                    .appFontBlack(size: 12, color: self.setColor(dollarGain, gainColor: gainColor, lossColor: lossColor))
//                            }
                        }
                    }
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
            }
            
            //MARK: List of Assets in the current selected Sector
            if isShowing {
                VStack {
                    HStack {
                        Text("Holdings")
//                            .appFontRegular(size: 12)
                        Spacer()
                    }
                    ForEach(assetDetails.continentAssets) { stock in
                        AssetDetailCell(
                            assetVM: AssetViewModel(equity: stock),
                            showUpdateCostBasis: $showUpdateCostBasis,
                            imageUrl: $assetImages[stock.symbol ?? "no_symbol"],
                            hasCostBasis: hasCostBasis,
                            assetDefaultColor: assetDefaultColor,
                            symbolFont: symbolFont,
                            fontColor: fontColor,
                            nameFont: nameFont,
                            assetDetailsHeaderFont: assetDetailsHeaderFont,
                            assetDetailsBodyFont: assetDetailsBodyFont,
                            assetDetailsHighlightColor: assetDetailsHighlightColor
                        )
                    }
                }
                .padding(.top)
            }
        }
        .padding()
        .background(Color(UIColor.tertiaryLabel))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color(UIColor.label), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            withAnimation(.easeInOut) {
                HapticTap.medium()
                self.isShowing.toggle()
            }
        }
    }
}


