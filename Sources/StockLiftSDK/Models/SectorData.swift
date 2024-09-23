//
//  SectorData.swift
//  Plaid-CloudFunctions
//
//  Created by Christopher Hicks on 7/22/22.
//

import SwiftUI

public struct SectorData {
    public var value: Double
    public var label: String
    
    public init(value: Double, label: String) {
        self.value = value
        self.label = label
    }
}
