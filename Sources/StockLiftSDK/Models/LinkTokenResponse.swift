//
//  LinkTokenResponse.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct LinkTokenResponse: Codable {
    public let expiration: String
    public let linkToken: String
    public let requestId: String
    public let accounts: [PlaidAccount]
    
    public init(expiration: String, linkToken: String, requestId: String, accounts: [PlaidAccount]) {
        self.expiration = expiration
        self.linkToken = linkToken
        self.requestId = requestId
        self.accounts = accounts
    }
    
    enum CodingKeys: String, CodingKey {
        case expiration
        case linkToken = "link_token"
        case requestId = "request_id"
        case accounts
    }
}



