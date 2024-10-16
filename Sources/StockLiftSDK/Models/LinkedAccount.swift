//
//  LinkedAccount.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/11/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct LinkedAccount: Identifiable, Codable {
    public let accessToken: String
    public let id: String
    public let name: String
    public let accounts: [PlaidAccount]?
    
    public init(accessToken: String, id: String, name: String, accounts: [PlaidAccount]?) {
        self.accessToken = accessToken
        self.id = id
        self.name = name
        self.accounts = accounts
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "plaid_access_token"
        case id = "institution_id"
        case name = "institution_name"
        case accounts
    }
}

public extension LinkedAccount {
    init?(documentData: [String: Any]) {
        let accessToken = documentData[FBKeys.Account.token] as? String ?? ""
        let id = documentData[FBKeys.Account.id] as? String ?? ""
        let name = documentData[FBKeys.Account.name] as? String ?? ""
        let accounts = documentData[FBKeys.Account.accounts] as? [PlaidAccount] ?? []
        
        self.init(accessToken: accessToken, id: id, name: name, accounts: accounts)
    }
}
