//
//  LinkedAccountResponse.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/30/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct LinkedAccountResponse: Codable {
    public let accounts: [LinkedAccount]
    
    public init(accounts: [LinkedAccount]) {
        self.accounts = accounts
    }
}
