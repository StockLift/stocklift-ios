//
//  PieChartSlice.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct PieChartSlice: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let path = Path { path in
                    
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    path.closeSubpath()
                }
                path
                    .fill(pieSliceData.color)
//                    .glow()
                    .overlay(path.strokedPath(.init(lineWidth: 1)))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

