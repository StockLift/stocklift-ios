//
//  File.swift
//  
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation

public struct TopHoldingAsset: Identifiable {
    public var id: String { holding.id }
    public var holding: UserEquity
    public let rank: Int
    
    public init(holding: UserEquity, rank: Int) {
        self.holding = holding
        self.rank = rank
    }
}
