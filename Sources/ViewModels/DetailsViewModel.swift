//
//  DetailsViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/19/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
final class DetailsViewModel: BaseViewModel, AssetDetails {
    
    let sectorDictionary: [[SectorTotals: [UserEquity]]]
    
    @Published var sectors = [SectorTotals]()
    @Published var equities = [[UserEquity]]()
    @Published var funds = [[UserEquity]]()
    
    init(sectDict: [[SectorTotals: [UserEquity]]]) {
        self.sectorDictionary = sectDict.sorted(by: {($0.keys.first?.percent ?? 0) > ($1.keys.first?.percent ?? 0)})
        super.init()
        sectorDictionary.forEach { (dict) in
            let sector = dict.map({ $0.key })
            sectors.append(contentsOf: sector)
            let equityData = dict.map({ item in
                item.value.filter { equity in
                    equity.type == .equity
                }
            })
            self.equities.append(contentsOf: equityData)
            let fundsData = dict.map({ item in
                item.value.filter { equity in
                    equity.type != .equity
                }
            })
            self.funds.append(contentsOf: fundsData)
        }
    }
    
    public static func updateCostBasis(symbol: String, value: Float) {
//        let request = UpdateCostBasis(symbol: symbol, costBasis: value)
//        NetworkService.shared.updateCostBasis(req: request) { result in
//            switch result {
//            case .success(_):
//                break
//            case .failure(let err):
////                self.handleAlert(err: err, codeSheet: "EquityDetailsViewModel+setCostBasis") {
//                    print(err)
////                }
//            }
//        }
    }
    
    
    private func checkEmptySector(_ sectors: [Sector]) -> Bool {
        var hasValue = true
        sectors.forEach { sector in
            if sector.amountInvested == 0 {
                hasValue = false
            }
        }
        return hasValue
    }
}
