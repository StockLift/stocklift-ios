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
    let sectorHeaderFont: Font
    let sectorHeaderFontColor: Color
    let sectorSubHeaderFont: Font
    let sectorSubHeaderFontColor: Color
    
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
            //MARK: CONTINENT HEADER
            // Continent Name & Click to open
            HStack {
                Text(continentName)
                    .font(sectorHeaderFont)
                    .fontWeight(.semibold)
                    .foregroundStyle(sectorHeaderFontColor)
                Spacer()
                Image(systemName: isShowing ? "chevron.down" : "chevron.right")
                    .imageHandler()
                    .foregroundColor(.white)
                    .frame(width: 12, height: 12)
            }
            .padding(.bottom)
            
            HStack {
                //MARK: LEFT CELL
                // 1. GAIN / LOSE Image
                // 2. CONTINENT WEIGHT & CHANGE
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if continentName != "Uncategorized" {
                            Image(systemName: self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor) == gainColor ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .imageHandler()
                                .foregroundStyle(self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor))
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .imageHandler()
                                .background(gainColor)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(continentWeight)%")
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.vertical, 0)
                            
                            Text("\(setSymbol(continentGain))%")
                                .font(.footnote)
                                .fontWeight(.black)
                                .foregroundStyle(self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor))
                        }
                    }
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(UIColor.label), lineWidth: 1))
                
                //MARK: RIGHT CELL
                // 1. GAIN / LOSE Image
                // 2. TOTAL VALUE & TOTAL VALUE CHANGE
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if continentName != "Uncategorized" {
                            Image(systemName: self.setColor(dollarGain, gainColor: gainColor, lossColor: lossColor) == gainColor ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .imageHandler()
                                .foregroundStyle(self.setColor(continentGain, gainColor: gainColor, lossColor: lossColor))
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .imageHandler()
                                .background(gainColor)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(totalAmountInvested)
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.vertical, 0)
                            
                            Text("\(setSymbol(dollarGain))")
                                .font(.footnote)
                                .fontWeight(.black)
                                .foregroundStyle(self.setColor(dollarGain, gainColor: gainColor, lossColor: lossColor))
                        }
                    }
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(UIColor.label), lineWidth: 1))
            }
            
            //MARK: List of Assets in the current selected Sector
            if isShowing {
                VStack {
                    HStack {
                        Text("Holdings")
                            .font(sectorSubHeaderFont)
                            .fontWeight(.semibold)
                            .foregroundStyle(sectorSubHeaderFontColor)
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


