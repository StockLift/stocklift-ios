//
//  ExchangeLinkTokenResponse.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/30/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation


public struct ExchangeLinkTokenResponse: Codable {
    public let accessToken: String
    public let itemId: String
    public let error: String?
    
    public init(accessToken: String, itemId: String, error: String?) {
        self.accessToken = accessToken
        self.itemId = itemId
        self.error = error
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case itemId = "item_id"
        case error
    }
}
