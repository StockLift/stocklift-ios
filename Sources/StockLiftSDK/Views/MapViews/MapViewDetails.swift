//
//  MapViewDetails.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/3/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct MapViewDetails: View {
    @StateObject var geoVM: GeoAssetViewModel
    @Binding var date: String
    @Binding var hasCostBasis: Bool
    var updateCostBasisAction: (String, Float) -> Void
    
    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    
    var body: some View {
        ZStack {
//            Color.appBackground.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    if !hasCostBasis {
                        Text(PortfolioViewModel.missingCostBasisMessage(date))
                            .appFontRegular(color: .gray)
                            .multilineTextAlignment(.center)
                    }
                    ForEach(geoVM.usersAssets, id: \.continent) { asset in
                        ContinentDetailCell(assetDetails: asset,
                                            showUpdateCostBasis: $showUpdateCostBasis,
                                            hasCostBasis: $hasCostBasis)
                    }
                }
            }
            .padding()
            .overlay(alignment: .center) {
                if showUpdateCostBasis.0 {
                    EditCostBasisView(updateCostBasisAction: updateCostBasisAction,
                                      showUpdateCostBasis: $showUpdateCostBasis)
                }
            }
        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            SLToolBar(title: "Geography Details") {
//                EmptyView()
//            }
//        }
    }
}

