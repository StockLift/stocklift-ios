//
//  SectorDetailCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct SectorDetailCell: View {
    @StateObject var sectorVM: SectorViewModel
    @State var isShowing: Bool = false
    @Binding var showUpdateCostBasis: (Bool, String)
    let hasCostBasis: Bool
    // -- Properties
    let gainColor: Color
    let lossColor: Color
    let sectorHeaderFont: Font
    let sectorHeaderFontColor: Color
    let sectorSubHeaderFont: Font
    let sectorSubHeaderFontColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let nameFont: Font
    
    var percentOfInvestment: String {
        sectorVM.percentOfInvestment
    }
    
    var amountInvested: Float {
        sectorVM.amountInvested
    }
    
    var percentInvestChange: String {
        sectorVM.percentInvestChange
    }
    
    var dollarChange: Float {
        sectorVM.dollarAmountChange
    }
    
    var sectorName: String {
        sectorVM.sector.sector?.localizedCapitalized ?? ""
    }
    
    var investGainLose: Bool {
        sectorVM.percentInvestGainLose
    }
    
    var dollarGainLose: String {
        if sectorVM.dollarChangeGainLose {
            return "+"
        } else {
            return ""
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            //MARK: SECTOR TOP HEADER
            // SECTOR TITLE & Click to open
            HStack {
                Text(sectorName)
                    .font(sectorHeaderFont)
                    .fontWeight(.semibold)
                    .foregroundStyle(sectorHeaderFontColor)
                Spacer()
                Image(systemName: isShowing ? "chevron.down" : "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.primary)
                    .frame(width: 12, height: 12)
                
            }
            .padding(.bottom)
            
            HStack {
                //MARK: LEFT CELL
                // 1. GAIN / LOSE Image
                // 2. TOTAL PERCENT & TOTAL PERCENT CHANGE
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if sectorName != "Cash" {
                            Image(systemName: investGainLose ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(investGainLose ? gainColor : lossColor)
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .background(gainColor)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(percentOfInvestment)%")
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.vertical, sectorName == "Cash" ? 8 : 0)
                            if sectorName != "Cash" {
                                Text("\(self.setSymbol(percentInvestChange))%")
                                    .font(.footnote)
                                    .fontWeight(.black)
                                    .foregroundStyle(investGainLose ? gainColor : lossColor)
                            }
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
                        if sectorName != "Cash" {
                            Image(systemName: sectorVM.dollarChangeGainLose ? ImageKeys.upArrow : ImageKeys.downArrow)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(investGainLose ? gainColor : lossColor)
                                .frame(width: 20, height: 20)
                        } else {
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .background(gainColor)
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(amountInvested, format: .currency(code: "USD"))
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.vertical, sectorName == "Cash" ? 8 : 0)
                            if sectorName != "Cash" {
                                Text("\(setSymbol(dollarChange.clean, insert: "$"))")
                                    .font(.footnote)
                                    .fontWeight(.black)
                                    .foregroundStyle(sectorVM.dollarChangeGainLose ? gainColor : lossColor)
                            }
                        }
                    }
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(UIColor.label), lineWidth: 1))
                
            }
            
            //MARK: - ASSETS for SECTOR
            if isShowing {
                VStack {
                    if determineSectorType() {
                        if !sectorVM.sectorStocks.isEmpty {
                            HStack {
                                Text("Stocks")
                                    .font(sectorSubHeaderFont)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(sectorSubHeaderFontColor)
                                Spacer()
                            }
                        }
                    }
                    
                    ForEach(sectorVM.sectorStocks) { stock in
                        AssetDetailCell(
                            assetVM: AssetViewModel(equity: stock, sector: sectorVM.sector),
                            showUpdateCostBasis: $showUpdateCostBasis,
                            hasCostBasis: hasCostBasis,
                            assetDefaultColor: assetDefaultColor,
                            symbolFont: symbolFont,
                            nameFont: nameFont
                        )
                    }
                    
                    if determineSectorType() {
                        if sectorName != "Bonds" && sectorName != "Bond" {
                            if !sectorVM.sectorFunds.isEmpty {
                                HStack {
                                    Text("Funds")
                                        .font(sectorSubHeaderFont)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(sectorSubHeaderFontColor)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    ForEach(sectorVM.sectorFunds) { stock in
                        AssetDetailCell(
                            assetVM: AssetViewModel(equity: stock, sector: sectorVM.sector),
                            showUpdateCostBasis: $showUpdateCostBasis,
                            hasCostBasis: hasCostBasis,
                            assetDefaultColor: assetDefaultColor,
                            symbolFont: symbolFont,
                            nameFont: nameFont
                        )
                    }
                }
                .padding(.top)
            }
            
        }
        .padding()
        .background(Color(UIColor.tertiaryLabel))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color(UIColor.systemBackground).opacity(0.6), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            withAnimation(.easeInOut) {
                HapticTap.medium()
                self.isShowing.toggle()
            }
        }
    }
    
    private func determineSectorType() -> Bool {
        var status = true
        if sectorName == "Cash" {
            status = false
        }
        if sectorName == "Crypto" {
            status = false
        }
        if sectorName == "Derivative" {
            status = false
        }
        if sectorName == "Fixed Income" {
            status = false
        }
        return status
    }
}
