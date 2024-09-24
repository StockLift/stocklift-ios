//
//  PortfolioDetails.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/7/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct PortfolioDetails: View {
    var sectorDetailsVM: AssetDetails
    @Binding var date: String
    @Binding var hasCostBasis: Bool
    let selectedSector: SelectedSector
    var updateCostBasisAction: (String, Float) -> Void

    @State private var showUpdateCostBasis: (Bool, String) = (false, "")
    
    var queryAssets: Range<Int> {
        sectorDetailsVM.sectors.indices
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    if !hasCostBasis {
                        Text(PortfolioViewModel.missingCostBasisMessage(date))
                            .appFontRegular(color: .gray)
                            .multilineTextAlignment(.center)
                    }
                    
                    ForEach(queryAssets, id: \.self) { index in
                        SectorDetailCell(sectorVM: SectorViewModel(sector: sectorDetailsVM.sectors[index],
                                                                   sectorFunds: sectorDetailsVM.funds[index],
                                                                   sectorStocks: sectorDetailsVM.equities[index]),
                                         isShowing: sectorIsSelected(sectorDetailsVM.sectors[index].sector), showUpdateCostBasis: $showUpdateCostBasis, hasCostBasis: hasCostBasis)
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
                if showUpdateCostBasis.0 {
                    EditCostBasisView(updateCostBasisAction: updateCostBasisAction, 
                                      showUpdateCostBasis: $showUpdateCostBasis)
                }
            }
        }
        .padding()
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

//struct ViewEquityDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewEquityDetails()
//    }
//}


