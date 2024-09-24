//
//  SectorViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/19/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
final class SectorViewModel: BaseViewModel {

    @Published var sector: SectorTotals
    @Published var sectorFunds: [UserEquity]
    @Published var sectorStocks: [UserEquity]
    @Published var amountInvested: Float = 0
    @Published var dollarAmountChange: Float = 0
    @Published var dollarChangeGainLose: Bool = false
    
    @Published var percentOfInvestment: String = ""
    
    @Published var percentInvestChange: String = ""
    @Published var percentInvestGainLose: Bool = false

    
    init(sector: SectorTotals, sectorFunds: [UserEquity], sectorStocks: [UserEquity]) {
        self.sector = sector
        //TODO: owners would like to sort the funds by the invested amount but currently that is not possible will need to refactor all logic and views
        self.sectorFunds = sectorFunds.sorted(by: {$0.institutionValue ?? 0 > $1.institutionValue ?? 0})
        self.sectorStocks = sectorStocks.sorted(by: {$0.institutionValue ?? 0 > $1.institutionValue ?? 0})
        super.init()
        initView(sector)
    }
    
    private func initView(_ sector: SectorTotals) {
        self.amountInvested = sector.amount ?? 0
        self.percentOfInvestment = sector.percent?.clean ?? ""
        self.percentInvestChange = sector.percentChange ?? ""
        self.dollarAmountChange = sector.dollarChange ?? 0
        
        self.percentInvestGainLose = checkUporDown(sector.percentChange ?? "")
        self.dollarChangeGainLose = checkUporDown(String(sector.dollarChange ?? 0))
    }
    
    //MARK: - GAIN or LOSE Image
    func checkUporDown(_ amount: String) -> Bool {
        var isUp = true
        if amount.first == "-" {
            isUp = false
        }
        return isUp
    }
}
