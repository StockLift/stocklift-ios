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
    
//    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // NAME
                HStack {
                    Text("Symbol")
//                        .headerFont()
                    Text(asset.symbol ?? "n/a")
//                        .bodyFont()
                }
                HStack {
                    Text("Cost Basis")
//                        .headerFont()
                    Text("\(asset.costBasis ?? 0)")
//                        .bodyFont(.yellow)
                }
//                .overlay(alignment: .trailing) {
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
//                        .headerFont()
                    Text("\(asset.institutionValue ?? 0)")
//                        .bodyFont()
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Close")
//                        .headerFont()
                    Text("\(asset.closePrice ?? 0)")
//                        .bodyFont()
                }
                HStack {
                    Text("Quantity")
//                        .headerFont()
                    Text("\(asset.quantity ?? 0)")
//                        .bodyFont()
                }
                HStack {
                    Text("Type")
//                        .headerFont()
                    Text(asset.type?.rawValue ?? "n/a")
//                        .bodyFont()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
//        .makeCardLayer(radius: 10)
//        .onReceive(timer, perform: { _ in
//            if counter < 5 {
//                withAnimation(.easeOut) { counter += 1 }
//            } else {
//                self.timer.upstream.connect().cancel()
//            }
//        })
    }
}


