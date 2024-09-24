//
//  AssetDetailCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI
//import Kingfisher

//TODO: - setup
@available(iOS 15.0, *)
struct AssetDetailCell: View {
    @StateObject var assetVM: AssetViewModel
    @State private var showDetails: Bool = false
    @Binding var showUpdateCostBasis: (Bool, String)
    let hasCostBasis: Bool
    
    var amount: Float {
        assetVM.amountInvested ?? 0
    }
    
    var percent: String {
        let change = ((Float(assetVM.equity.institutionValue ?? 0) / Float(assetVM.equity.costBasis ?? 0)) - 1) * 100
        return change.clean
    }
    
    var url: URL? {
        assetVM.symbolImage
    }
    
    var symbol: String {
        var symbolString = ""
        if assetVM.isBond {
            symbolString = "Bond"
        } else {
            symbolString = assetVM.equity.type?.rawValue.localizedCapitalized ?? ""
        }
        return symbolString
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
                if !assetVM.isCrypto {
                    if let url = url {
//                        KFImage(url)
////                            .loadDiskFileSynchronously()
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 40, height: 40)
//                            .background(Color.appBlue)
//                            .clipShape(Circle())
//                            .padding(.trailing, 8)
                    } else {
                        if let image = assetVM.equity.symbol {
                            Text(assetVM.isCash ? "$" : image.prefix(5))
                                .appFontRegular(size: assetVM.isCash ? 14 : 12)
                                .shadow(radius: 2)
                                .frame(width: 40, height: 40)
                                .background(Color.appBlue)
                                .clipShape(Circle())
                                .padding(.trailing, 8)
                        } else {
                            Text("")
                                .appFontRegular(size: assetVM.isCash ? 10 : 12)
                                .shadow(radius: 2)
                                .frame(width: 40, height: 40)
                                .background(Color.appBlue)
                                .clipShape(Circle())
                                .padding(.trailing, 8)
                        }
                    }
                }
                

            
            VStack(alignment: .trailing, spacing: 0) {
                HStack {
                    Text(assetVM.equity.symbol ?? symbol)
                        .appFontBlack()
                    
                    Spacer()
                    
                    TotalAmountView
                }
                
                HStack {
                    Text(assetVM.equity.name ?? "")
                        .appFontRegular(size: 12)
                    
                    Spacer()
                    
                    if !assetVM.isCash {
                        Text("\(setSymbol(percent))%")
                            .appFontRegular(size: 12)
                    }
                 
                }
            }
        }
        .padding(8)
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
        .overlay(alignment: .center, content: {
            if showDetails {
                PopUpDetailView(asset: assetVM.equity, 
                                showUpdateCostBasis: $showUpdateCostBasis,
                                hasCostBasis: hasCostBasis,
                                hideView: $showDetails)
            }
        })
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut) {
                showDetails.toggle()
            }
        }
    }
    
    @ViewBuilder
    private var TotalAmountView: some View {
        if assetVM.isFund {
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(amount, format: .currency(code: "USD"))
                        .appFontBlack()
                    
                    Text(" of ")
                        .appFontRegular(size: 12)
                    
                    Text(assetVM.equity.institutionValue ?? 0, format: .currency(code: "USD"))
                        .appFontBlack()
                }
            }
            
        } else {
            Text(amount, format: .currency(code: "USD"))
                .appFontBlack()
        }
    }
}

//struct EquityDetailCard_Previews: PreviewProvider {
//    static var previews: some View {
//        EquityDetailCard()
//            .previewLayout(.sizeThatFits)
//
//            .padding()
//    }
//}

