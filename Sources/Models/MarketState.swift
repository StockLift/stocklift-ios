//
//  MarketState.swift
//  Stocklift
//
//  Created by Christopher Hicks on 10/14/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import Foundation

public struct MarketState: Codable {
    public let isOpen: Bool
    
    public init(isOpen: Bool) {
        self.isOpen = isOpen
    }
    
    enum CodingKeys: String, CodingKey {
        case isOpen = "is_open"
    }
}
