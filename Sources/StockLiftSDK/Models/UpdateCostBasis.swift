//
//  UpdateCostBasis.swift
//
//
//  Created by Christopher Hicks on 7/26/24.
//

import Foundation

public struct UpdateCostBasis: BaseRequest {
    public let symbol: String
    public let costBasis: Float
    
    public init(symbol: String, costBasis: Float) {
        self.symbol = symbol
        self.costBasis = costBasis
    }
}
