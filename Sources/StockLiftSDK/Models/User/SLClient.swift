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
    var age: Int?
    var country: String?
    var state: String?
    
    public init(uuid: String, name: String, email: String, age: Int? = nil, country: String? = nil, state: String? = nil) {
        self.uuid = uuid
        self.name = name
        self.email = email
        self.age = age
        self.country = country
        self.state = state
    }
}
