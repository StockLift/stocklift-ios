//
//  PlaidExchangeRequest.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/30/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct PlaidExchangeRequest: BaseRequest {
    public let publicToken: String
    public let institutionName: String
    public let institutionId: String
    public let accounts: [PlaidAccount]
    
    public init(publicToken: String, institutionName: String, institutionId: String, accounts: [PlaidAccount]) {
        self.publicToken = publicToken
        self.institutionName = institutionName
        self.institutionId = institutionId
        self.accounts = accounts
    }
}
