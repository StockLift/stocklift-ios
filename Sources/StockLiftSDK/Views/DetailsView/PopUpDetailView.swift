//
//  PopUpDetailView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/2/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct PopUpDetailView: View {
    let asset: UserEquity
    @Binding var showUpdateCostBasis: (Bool, String)
    let hasCostBasis: Bool
    @Binding var hideView: Bool
    
    let offset: CGFloat // top holdings = -10 --- sector details = 0
    let verticalPadding: CGFloat // top holdings = 2 ---- sector details = 8
    let headerFont: Font // caption
    let bodyFont: Font // caption2
    let highlightColor: Color  // yellow
    
//    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
    
    var body: some View {
        HStack {
            //MARK: LEFT Side Details
            VStack(alignment: .leading) {
                // NAME
                HStack {
                    Text("Symbol")
                        .font(headerFont)
                    Text(asset.symbol ?? "n/a")
                        .font(bodyFont)
                }
                HStack {
                    Text("Cost Basis")
                        .font(headerFont)
                    Text("\(asset.costBasis ?? 0)")
                        .font(bodyFont)
                        .foregroundStyle(highlightColor)
                }
//                .overlay(alignment: .trailing) {
                //MARK: EDIT COST BASIS 
//                    if counter < 2 && !hasCostBasis {
//                        Text("Click to update")
//                            .padding(.horizontal, 8)
//                            .background(Color.gray.opacity(0.2))
//                            .clipShape(.rect(cornerRadius: 10))
//                            .headerFont(.yellow)
//                    }
//                }
//                .onTapGesture {
//                    if !hasCostBasis {
//                        showUpdateCostBasis.1 = asset.symbol ?? asset.id
//                        showUpdateCostBasis.0.toggle()
//                    } else {
//                        hideView.toggle()
//                    }
//                }
                HStack {
                    Text("Value")
                        .font(headerFont)
                    Text("\(asset.institutionValue ?? 0)")
                        .font(bodyFont)
                }
            }
            
            Spacer()
            
            //MARK: RIGHT Side Details
            VStack(alignment: .leading) {
                HStack {
                    Text("Close")
                        .font(headerFont)
                    Text("\(asset.closePrice ?? 0)")
                        .font(bodyFont)
                }
                HStack {
                    Text("Quantity")
                        .font(headerFont)
                    Text("\(asset.quantity ?? 0)")
                        .font(bodyFont)
                }
                HStack {
                    Text("Type")
                        .font(headerFont)
                    Text(asset.type?.rawValue ?? "n/a")
                        .font(bodyFont)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 2)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .offset(y: offset)
//        .onReceive(timer, perform: { _ in
//            if counter < 5 {
//                withAnimation(.easeOut) { counter += 1 }
//            } else {
//                self.timer.upstream.connect().cancel()
//            }
//        })
    }
}


