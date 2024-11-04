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
    
    let gainColor: Color
    let lossColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let nameFont: Font
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    
    var body: some View {
        ZStack {
//            Color.appBackground.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
//                    if !hasCostBasis {
//                        Text(PortfolioViewModel.missingCostBasisMessage(date))
//                            .appFontRegular(color: .gray)
//                            .multilineTextAlignment(.center)
                    //                    }
                    ForEach(geoVM.usersAssets, id: \.continent) { asset in
                        ContinentDetailCell(
                            assetDetails: asset,
                            showUpdateCostBasis: $showUpdateCostBasis,
                            hasCostBasis: $hasCostBasis,
                            gainColor: gainColor,
                            lossColor: lossColor,
                            assetDefaultColor: assetDefaultColor,
                            symbolFont: symbolFont,
                            nameFont: nameFont,
                            assetDetailsHeaderFont: assetDetailsHeaderFont,
                            assetDetailsBodyFont: assetDetailsBodyFont,
                            assetDetailsHighlightColor: assetDetailsHighlightColor
                        )
                    }
                }
            }
            .padding()
            .overlay(alignment: .center) {
                //                if showUpdateCostBasis.0 {
//                    EditCostBasisView(updateCostBasisAction: updateCostBasisAction,
//                                      showUpdateCostBasis: $showUpdateCostBasis)
//                }
            }
        }
    }
}

