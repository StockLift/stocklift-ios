//
//  PieChartSlice.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct PieChartSlice: View {
    
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            if #available(iOS 15.0, *) {
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
                        .glow()
                        .overlay(path.strokedPath(.init(lineWidth: 1)))

                    
                    //
                    //                  Text(pieSliceData.text)
                    //                      .position(
                    //                          x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                    //                          y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    //                      )
                    //                      .foregroundColor(Color.white)
                }

            } else { }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    

}

