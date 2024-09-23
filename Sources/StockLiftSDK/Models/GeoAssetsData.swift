//
//  GeoAssetsData.swift
//
//
//  Created by Christopher Hicks on 8/9/24.
//

import Foundation

public struct GeoAssetsData: Codable {
    public let continent: String
    public let continentWeight: Decimal
    public let continentGain: Decimal
    public let continentTotalValue: Decimal
    public let continentDollarGain: Decimal
    public let continentAssets: [UserEquity]
    
    public init(continent: String, continentWeight: Decimal, continentGain: Decimal, continentTotalValue: Decimal, continentDollarGain: Decimal, continentAssets: [UserEquity]) {
        self.continent = continent
        self.continentWeight = continentWeight
        self.continentGain = continentGain
        self.continentTotalValue = continentTotalValue
        self.continentDollarGain = continentDollarGain
        self.continentAssets = continentAssets
    }
}
