//
//  AssetDetailCell.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI
import Kingfisher

//TODO: - setup
@available(iOS 15.0, *)
struct AssetDetailCell: View {
    @StateObject var assetVM: AssetViewModel
    @State private var showDetails: Bool = false
    @Binding var showUpdateCostBasis: (Bool, String)
    let hasCostBasis: Bool
    
    // - PROPERTIES
    let assetDefaultColor: Color
    let symbolFont: Font
    let nameFont: Font
    
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
                //MARK: - ASSET IMAGE
                if let url = url {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(assetDefaultColor)
                        .clipShape(Circle())
                        .padding(.trailing, 8)
                } else {
                    if let image = assetVM.equity.symbol {
                        Text(assetVM.isCash ? "$" : image.prefix(4))
                            .font(assetVM.isCash ? .callout : .caption)
                            .fontWeight(.semibold)
                            .frame(width: 40, height: 40)
                            .background(assetDefaultColor)
                            .clipShape(Circle())
                            .padding(.trailing, 8)
                    } else {
                        Circle()
                            .fill(assetDefaultColor)
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 8)
                    }
                }
            }
            
            //MARK: - ASSET DETAILS
            VStack(alignment: .trailing, spacing: 0) {
                HStack {
                    // SYMBOL
                    Text(assetVM.equity.symbol ?? symbol)
                        .font(symbolFont)
                        .fontWeight(.black)
                    Spacer()
                    // TOTAL AMOUNT
                    TotalAmountView
                }
                HStack {
                    // NAME
                    Text(assetVM.equity.name ?? "")
                        .font(nameFont)
                    Spacer()
                    // PERCENT CHANGE
                    if !assetVM.isCash {
                        Text("\(setSymbol(percent))%")
                            .font(.caption)
                    }
                }
            }
        }
        .padding(8)
        .background(Color(UIColor.tertiaryLabel))
        .cornerRadius(10)
        .contentShape(Rectangle())
        .overlay(alignment: .center, content: {
            if showDetails {
                PopUpDetailView(asset: assetVM.equity,
                                showUpdateCostBasis: $showUpdateCostBasis,
                                hasCostBasis: hasCostBasis,
                                hideView: $showDetails)
            }
        })
        .onTapGesture {
            withAnimation(.easeInOut) {
                //TODO: - SETUP
                //                                showDetails.toggle()
            }
        }
    }
    
    //MARK: TOTAL AMOUNT VIEW
    @ViewBuilder
    private var TotalAmountView: some View {
        if assetVM.isFund {
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(amount, format: .currency(code: "USD"))
                        .fontWeight(.black)
                    Text(" of ")
                    Text(assetVM.equity.institutionValue ?? 0, format: .currency(code: "USD"))
                        .fontWeight(.black)
                }
            }
            .font(.caption)
        } else {
            Text(amount, format: .currency(code: "USD"))
                .font(.caption)
                .fontWeight(.black)
        }
    }
}
