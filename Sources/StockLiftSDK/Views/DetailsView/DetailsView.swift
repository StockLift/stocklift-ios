//
//  DetailsView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/15/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

//TODO: - setup
@available(iOS 15.0, *)
struct DetailsView: View {
    @StateObject var sectorDetailsVM: DetailsViewModel
    @Binding var date: String
    let hasCostBasis: Bool
    let selectedSector: SelectedSector
    
    @State private var showEnterStock: Bool = false
    @State private var symbolText: String = ""
    @State private var costBasisText: String = ""
    @State private var quantityText: String = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            PortfolioDetails(sectorDetailsVM: sectorDetailsVM,
                             date: $date, 
                             hasCostBasis: hasCostBasis,
                             selectedSector: selectedSector,
                             updateCostBasisAction: updateCostBasisAction)
//            .setAnalyticsView("Portfolio Details View")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            SLToolBar(title: "Sector Details") {
//                EmptyView()
//            }
//        }
    }
    
    private func updateCostBasisAction(_ symbol: String, value: Float) {
        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
