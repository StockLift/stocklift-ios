//
//  PlaidAccount.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/30/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct PlaidAccount: Codable, Identifiable {
    public let id: String
    public let name: String
    public let mask: String?
    
    public init(id: String, name: String, mask: String?) {
        self.id = id
        self.name = name
        self.mask = mask
    }
}
