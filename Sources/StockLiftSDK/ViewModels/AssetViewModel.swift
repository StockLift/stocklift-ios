//
//  AssetViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/20/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

//TODO: - config
@available(iOS 13.0, *)
final class AssetViewModel: BaseViewModel {
    
    let equity: UserEquity
    let sector: SectorTotals?
    @Published var amountInvested: Float? = nil
    @Published var symbolImage: URL? = nil
    @Published var isFund = false
    @Published var isCrypto = false
    @Published var isCash = false
    @Published var isBond = false
    
    init(equity: UserEquity, sector: SectorTotals? = nil) {
        self.equity = equity
        self.sector = sector
        super.init()
        if let symbol = equity.symbol, symbol != "" {
            AssetViewModel.getAssetImage(symbol) { url in
                self.symbolImage = url
            }
        }
        self.setSectorPercent()
        if sector != nil {
            self.isFund = self.checkIsFund(equity)
        } else {
            self.amountInvested = equity.institutionValue
            self.isFund = false
        }
        

        if equity.type == .cryptocurrency {
            self.isCrypto = true
            self.isFund = false
        }
        
        if equity.type == .cash {
            self.isCash = true
            self.isFund = false
        }
        
        if equity.type == .bonds || equity.type == .bond {
            self.isCash = false
            self.isFund = false
            self.isBond = true
        }
        
        if equity.type == .derivative {
            self.isCash = true
            self.isFund = false
        }
        
        if equity.type == .fixedIncome {
            self.isCash = false
            self.isFund = false
        }
        
    }
    
    private func checkIsFund(_ equity: UserEquity) -> Bool {
        let type = equity.type
        if type != .equity {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - SECTOR PERCENT
    private func setSectorPercent() {
        if let sector = self.sector {
            let sectorName = sector.sector?.lowercased().replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: " ", with: "")
            self.equity.sectors?.forEach({ sector in
                if sector.sector?.lowercased().replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: " ", with: "") == sectorName {
                    self.amountInvested = sector.amountInvested
                    
                }
            })
        }
    }
    
    
    //MARK: GET ASSET IMAGE
    static func getAssetImage(_ symbol: String, complete: @escaping (URL?) -> Void) {
        NetworkService.shared.getAssetImageUrl(symbol: symbol) { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    complete(URL(string: res.url ?? ""))
                }
            case .failure(_):
                complete(nil)
            }
        }
    }
    
    
}
