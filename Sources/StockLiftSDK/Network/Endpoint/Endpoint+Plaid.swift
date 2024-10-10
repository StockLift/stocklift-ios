//
//  Endpoint+Plaid.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

public extension Endpoint {
    // LINK TOKEN
    static var plaidLinkToken: Endpoint {
        Endpoint(path: APIPath.v1.plaidLinkToken)
    }
}
