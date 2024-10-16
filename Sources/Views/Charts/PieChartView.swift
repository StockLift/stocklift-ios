//
//  PieChartView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct PieChartView: View {
    public let values: [Double]
    public var colors: [Color]
    
    public var backgroundColor: Color?
    
    var offset: Double = 1.25
    var addAction: (() -> Void)?
    var removeAction: (() -> Void)?
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
                if #available(iOS 16.0, *) {
                    ForEach(0..<self.values.count, id: \.self) { i in
                        PieChartSlice(pieSliceData: self.slices[i])
//                            .onTapGesture {
//                                print("PIE CHART Tapped ****** \(i) SLICES **** \(slices[i])")
//                            }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: -geometry.size.width / 2)
                    .clipped()
                    .offset(x: geometry.size.width / 4)
                    .overlay(alignment: .center) {
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: geometry.size.width / offset)
                            .rotationEffect(.degrees(-90))
                            .offset(x: -geometry.size.width / 4)
                            .overlay(alignment: .center) {
                                
                                /// PORTFOLIO
                                Circle()
                                    .trim(from: 0, to: 0.5)
                                    .fill(Color.gray.opacity(0.4))
                                    .frame(width: (geometry.size.width / 2) / offset)
                                    .rotationEffect(.degrees(-90))
                                    .offset(x: -geometry.size.width / 4)
                                
                                
                            }
                    }
                    
                } else {
                    Text("Please update your phone")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
        }
    }
    
//    private func setOffset(_ geo: GeometryProxy) -> CGFloat {
//        switch UIDevice().type {
//            
//        case .iPhone13ProMax:
//            return -geo.size.width / 24 + 23
//        case .iPhone12Pro:
//            return -geo.size.width / 24 + 21
//        case .iPhone12:
//            return -geo.size.width / 24 + 22
//        case .iPhone11Pro: // Shannan
//            return -geo.size.width / 24 + 20.5
//        case .iPhone11:
//            return -geo.size.width / 24 + 23
//        case .iPhone8:
//            return -geo.size.width / 24 + 23
//            
//        case .iPhoneXSMax:
//            return -geo.size.width / 24 + 23
//        case .iPhoneXR:
//            return -geo.size.width / 24 + 23
//        case .iPhoneXS:
//            return -geo.size.width / 24 + 23
//        case .iPhoneX:
//            return -geo.size.width / 24 + 23
//            
//            
//        default:
//            return -geo.size.width / 24 + 23
//        }
//    }
//    
//    private var width: CGFloat {
//        switch UIDevice().type {
//        case .iPhone11Pro:
//            return 21
//        default: return 23
//        }
//    }
}
