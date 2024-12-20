//
//  PortfolioDetails.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct PortfolioDetails: View {
    @StateObject var sectorDetailsVM: DetailsViewModel
    @Binding var assetImages: [String: URL]
    
    // - Properties
    let date: String
    let hasCostBasis: Bool
    let selectedSector: SelectedSector
    var updateCostBasisAction: (String, Float) -> Void
    let gainColor: Color
    let lossColor: Color
    let sectorHeaderFont: Font 
    let sectorHeaderFontColor: Color
    let sectorSubHeaderFont: Font
    let sectorSubHeaderFontColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let fontColor: Color
    let nameFont: Font
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    
    var queryAssets: Range<Int> {
        sectorDetailsVM.sectors.indices
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            VStack {
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        if !hasCostBasis {
                            Text(PortfolioViewModel.missingCostBasisMessage(date))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        ForEach(queryAssets, id: \.self) { index in
                            SectorDetailCell(
                                sectorVM: SectorViewModel(
                                    sector: sectorDetailsVM.sectors[index],
                                    sectorFunds: sectorDetailsVM.funds[index],
                                    sectorStocks: sectorDetailsVM.equities[index]
                                ),
                                isShowing: sectorIsSelected(sectorDetailsVM.sectors[index].sector),
                                showUpdateCostBasis: $showUpdateCostBasis,
                                assetImages: $assetImages,
                                hasCostBasis: hasCostBasis,
                                gainColor: gainColor,
                                lossColor: lossColor,
                                sectorHeaderFont: sectorHeaderFont,
                                sectorHeaderFontColor: sectorHeaderFontColor,
                                sectorSubHeaderFont: sectorSubHeaderFont,
                                sectorSubHeaderFontColor: sectorSubHeaderFontColor,
                                assetDefaultColor: assetDefaultColor,
                                symbolFont: symbolFont,
                                fontColor: fontColor,
                                nameFont: nameFont,
                                assetDetailsHeaderFont: assetDetailsHeaderFont,
                                assetDetailsBodyFont: assetDetailsBodyFont,
                                assetDetailsHighlightColor: assetDetailsHighlightColor
                            )
                            .id(sectorDetailsVM.sectors[index].sector)
                        }
                    }
                    .padding(.bottom)
                    .onAppear {
                        if selectedSector != .none {
                            proxy.scrollTo(selectedSector.rawValue.lowercased(), anchor: .top)
                        }
                    }
                }
                .overlay(alignment: .center) {
                    //                if showUpdateCostBasis.0 {
                    //                    EditCostBasisView(updateCostBasisAction: updateCostBasisAction,
                    //                                      showUpdateCostBasis: $showUpdateCostBasis)
                    //                }
                }
            }
            .padding()
        }
    }
    
    private func sectorIsSelected(_ sector: String?) -> Bool {
        if let sector = sector {
            if sector == selectedSector.rawValue.lowercased() {
                return true
            }
        }
        return false
    }
}
