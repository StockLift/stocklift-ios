//
//  AssetCoordinates.swift
//
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation
import MapKit

public struct AssetCoordinates: Identifiable {
    public let id = UUID()
    public let name: String
    public let coordinate: CLLocationCoordinate2D
    public var url: String?
    public var symbol: String?
    
    public init(name: String, coordinate: CLLocationCoordinate2D, url: String? = nil, symbol: String? = nil) {
        self.symbol = symbol
        self.coordinate = coordinate
        self.url = url
        self.name = name
    }
}
