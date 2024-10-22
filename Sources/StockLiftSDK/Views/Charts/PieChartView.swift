//
//  PieChartView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct PieChartView: View {
    
    public let values: [Double]
    public var colors: [Color]
    public var backgroundColor: Color?
    
    var offset: Double = 1.25
    var addAction: (() -> Void)?
    var removeAction: (() -> Void)?
    
    /// * SLICES *
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 180 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg),
                                           endAngle: Angle(degrees: endDeg + degrees),
                                           text: String(format: "%.0f%%", value * 100 / sum),
                                           color: self.colors[i])
            )
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.values.count, id: \.self) { i in
                    PieChartSlice(pieSliceData: self.slices[i])
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: -geometry.size.width / 2)
                .clipped()
                .offset(x: geometry.size.width / 4)
                .overlay(alignment: .center) {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color(UIColor.systemBackground))
                        .frame(width: geometry.size.width / offset)
                        .rotationEffect(.degrees(-90))
                        .offset(x: -geometry.size.width / 4)
                        .overlay(alignment: .center) {
                            /// PORTFOLIO
                            Circle()
                                .trim(from: 0, to: 0.5)
                                .fill(Color(UIColor.label).opacity(0.4))
                                .frame(width: (geometry.size.width / 2) / offset)
                                .rotationEffect(.degrees(-90))
                                .offset(x: -geometry.size.width / 4)
                        }
                }
            }
        }
    }
}
