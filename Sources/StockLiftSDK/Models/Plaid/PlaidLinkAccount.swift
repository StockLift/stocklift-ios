//
//  PlaidLinkAccount.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

struct PlaidLinkAccount {
    let token: String
    let name: String
    let id: String
    let accounts: [PlaidAccount]
}
