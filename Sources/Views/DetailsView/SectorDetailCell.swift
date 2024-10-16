//
//  SectorDetailCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

//TODO: config haptic
@available(iOS 15.0, *)
struct SectorDetailCell: View {
    @StateObject var sectorVM: SectorViewModel
    @State var isShowing: Bool = false
    @Binding var showUpdateCostBasis: (Bool, String)
    let hasCostBasis: Bool
    
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
            
            HStack {
                Text(sectorName)
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
                        
                        if sectorName != "Cash" {
                            Image(investGainLose ? "upArrow" : "downArrow")
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
                            Text("\(percentOfInvestment)%")
                                .appFontBlack(size: 16)
                                .padding(.vertical, sectorName == "Cash" ? 8 : 0)
                            
                            if sectorName != "Cash" {
                                Text("\(self.setSymbol(percentInvestChange))%")
                                    .appFontBlack(size: 12, color: investGainLose ? Color.blue : Color.red)
                            }
                        }
                    }
                    
                   
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
                
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        if sectorName != "Cash" {
                            Image(sectorVM.dollarChangeGainLose ? "upArrow" : "downArrow")
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
                            
                            if #available(iOS 15.0, *) {
                                Text(amountInvested, format: .currency(code: "USD"))
                                    .appFontBlack(size: 16)
                                    .padding(.vertical, sectorName == "Cash" ? 8 : 0)
                                
                            } else {}
                            
                            if sectorName != "Cash" {
                                Text("\(setSymbol(dollarChange.clean, insert: "$"))")
                                    .appFontBlack(size: 12, color: sectorVM.dollarChangeGainLose ? Color.blue : Color.red)
                            }
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
                    if determineSectorType() {
                        if !sectorVM.sectorStocks.isEmpty {
                            HStack {
                                Text("Stocks")
                                    .appFontRegular(size: 12)
                                Spacer()
                            }
                        }
                    }
                    
                    ForEach(sectorVM.sectorStocks) { stock in
                        AssetDetailCell(assetVM: AssetViewModel(equity: stock, sector: sectorVM.sector),
                                         showUpdateCostBasis: $showUpdateCostBasis,
                                         hasCostBasis: hasCostBasis)
                    }
                    
                    if determineSectorType() {
                        if sectorName != "Bonds" && sectorName != "Bond" {
                            if !sectorVM.sectorFunds.isEmpty {
                                HStack {
                                    Text("Funds")
                                        .appFontRegular(size: 12)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    ForEach(sectorVM.sectorFunds) { stock in
                        AssetDetailCell(assetVM: AssetViewModel(equity: stock, sector: sectorVM.sector),
                                         showUpdateCostBasis: $showUpdateCostBasis,
                                         hasCostBasis: hasCostBasis)
                    }
                }
                .padding(.top)
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.7))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            withAnimation(.easeInOut) {
//                HAPTIC.impactOccurred()
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

//struct SectorDetailCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SectorDetailCard()
//            .padding()
//    }
//}

