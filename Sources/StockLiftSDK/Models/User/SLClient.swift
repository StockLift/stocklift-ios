//
//  SLClient.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

public struct SLClient: Codable {
    //TODO: - ****** remove PUBLIC wrapper before release
    public let uuid: String
    public let name: String
    public let email: String
    public var age: Int?
    public var country: SLClientCountry?
    public var state: String?
    //TODO: - ****** remove PUBLIC wrapper before release
    public init(uuid: String, name: String, email: String, age: Int? = nil, country: SLClientCountry? = .unitedStates, state: String? = nil) {
        self.uuid = uuid
        self.name = name
        self.email = email
        self.age = age
        self.country = country
        self.state = state
    }
}


