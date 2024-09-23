//
//  PieChartData.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct PieChartData: Identifiable, Hashable {
    public let id = UUID()
    public let value: Double
    public let label: String
    public let color: Color
    
    public init(value: Double, label: String, color: Color) {
        self.value = value
        self.label = label
        self.color = color
    }
}
