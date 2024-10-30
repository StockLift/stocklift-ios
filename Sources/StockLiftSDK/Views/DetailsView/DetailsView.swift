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
    let date: String
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
                             date: date, 
                             hasCostBasis: hasCostBasis,
                             selectedSector: selectedSector,
                             updateCostBasisAction: updateCostBasisAction)
        }
    }
    
    private func updateCostBasisAction(_ symbol: String, value: Float) {
        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
}
