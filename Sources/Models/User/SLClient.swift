//
//  SLClient.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

public struct SLClient: Codable {
    let uuid: String
    let name: String
    let email: String
    
    public init(uuid: String, name: String, email: String) {
        self.uuid = uuid
        self.name = name
        self.email = email
    }
}
