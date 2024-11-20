//
//  GeoAssetsData.swift
//
//
//  Created by Christopher Hicks on 8/9/24.
//

import Foundation

struct GeoAssetsData: Codable, Identifiable {
    var id: String { continent }
    let continent: String
    let continentWeight: Decimal
    let continentGain: Decimal
    let continentTotalValue: Decimal
    let continentDollarGain: Decimal
    let continentAssets: [UserEquity]
    
    init(continent: String, continentWeight: Decimal, continentGain: Decimal, continentTotalValue: Decimal, continentDollarGain: Decimal, continentAssets: [UserEquity]) {
        self.continent = continent
        self.continentWeight = continentWeight
        self.continentGain = continentGain
        self.continentTotalValue = continentTotalValue
        self.continentDollarGain = continentDollarGain
        self.continentAssets = continentAssets
    }
}
