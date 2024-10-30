//
//  PlaidTokenResponse.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

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
