//
//  File.swift
//  
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation

struct TopHoldingAsset: Identifiable {
    var id: String { holding.id }
    var holding: UserEquity
    let rank: Int
    
   init(holding: UserEquity, rank: Int) {
        self.holding = holding
        self.rank = rank
    }
}
