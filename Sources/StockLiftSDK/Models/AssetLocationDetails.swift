//
//  AssetLocationDetails.swift
//
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation

/// ----------------------- ASSET LOCATION CHART/ MAP
public struct AssetLocationDetails: Codable {
    public let symbol: String
    public let country: String
    public let city: String?
    public let url: String?
    public let lat: Double?
    public let lng: Double?
    
    public init(symbol: String, country: String, city: String?, url: String? = nil, lat: Double?, lng: Double?) {
        self.symbol = symbol
        self.country = country
        self.city = city
        self.url = url
        self.lat = lat
        self.lng = lng
    }
}
