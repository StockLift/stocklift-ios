//
//  AssetLocationResponse.swift
//
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation

/// ----------------------- ASSET LOCATION CHART/ MAP
public struct AssetLocationResponse: Codable {
    public let data: [AssetLocationDetails]
    public let missingSymbols: Int
    
    public init(data: [AssetLocationDetails], missingSymbols: Int) {
        self.data = data
        self.missingSymbols = missingSymbols
    }
}
