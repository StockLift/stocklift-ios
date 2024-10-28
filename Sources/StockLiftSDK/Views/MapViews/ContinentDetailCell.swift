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
    @State var isShowing: Bool = false
    @Binding var showUpdateCostBasis: (Bool, String)
    @Binding var hasCostBasis: Bool
    
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
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text(continentName)
                    .appFontMedium()
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
                            Image(self.setColor(continentGain) == Color.green ? ImageKeys.upArrow : ImageKeys.downArrow, bundle: .module)
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
                                .appFontBlack(size: 16)
                                .padding(.vertical, 0)
                            
//                            if continentName != "Uncategorized" {
                                Text("\(setSymbol(continentGain))%")
                                    .appFontBlack(size: 12, color: self.setColor(continentGain, upColor: .blue))
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
                            Image(self.setColor(dollarGain) == Color.green ? ImageKeys.upArrow : ImageKeys.downArrow, bundle: .module)
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
                                .appFontBlack(size: 16)
                                .padding(.vertical, 0)
                            
//                            if continentName != "Uncategorized" {
                                Text("\(setSymbol(dollarGain))")
                                    .appFontBlack(size: 12, color: self.setColor(dollarGain, upColor: .blue))
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
                            .appFontRegular(size: 12)
                        Spacer()
                    }
                    ForEach(assetDetails.continentAssets) { stock in
                        AssetDetailCell(assetVM: AssetViewModel(equity: stock),
                                        showUpdateCostBasis: $showUpdateCostBasis,
                                        hasCostBasis: hasCostBasis)
                    }
                }
                .padding(.top)
            }
        }
        .padding()
//        .background(Color.appSectorCards)
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            withAnimation(.easeInOut) {
                HapticTap.medium.impactOccurred()
                self.isShowing.toggle()
            }
        }
    }
}


