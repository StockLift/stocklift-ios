//
//  SLClientCountry.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 11/19/24.
//

import Foundation

public enum SLClientCountry: String, Codable {
    case unitedStates = "US"
    case canada = "CA"
    
    //TODO: - ****** remove DESCRIPTION wrapper before release
    public var description: String {
        self.rawValue
    }
}
