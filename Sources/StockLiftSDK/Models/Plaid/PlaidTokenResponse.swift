//
//  PlaidTokenResponse.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

/**
 {
     "expiration": "2024-10-10T10:32:36Z",
     "link_token": "link-production-eebeb036-076a-4afb-a554-1971bc95307d",
     "request_id": "hJwiD2Ck41ltfl0"
 }
 */

public struct PlaidTokenResponse: Codable {
    public let expiration: String
    public let linkToken: String
    public let requestId: String
    
    public init(expiration: String, linkToken: String, requestId: String) {
        self.expiration = expiration
        self.linkToken = linkToken
        self.requestId = requestId
    }
    
    enum CodingKeys: String, CodingKey {
        case expiration
        case linkToken = "link_token"
        case requestId = "request_id"
    }
}
