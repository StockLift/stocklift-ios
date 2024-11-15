//
//  LegendFooter.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/13/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct LegendFooter: View {
    let sp500Color: Color
    let portfolioColor: Color
    let legendFont: Font
    let legendTextColor: Color
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            LegendCell(color: portfolioColor, title: "My Portfolio")
            LegendCell(color: sp500Color, title: "S&P 500")
        }
    }
    
    @ViewBuilder
    private func LegendCell(color: Color, title: String) -> some View {
        HStack(alignment: .center, spacing: 4) {
            Circle().fill(color)
                .frame(width: 8, height: 8)
            Text(title)
                .font(legendFont)
                .foregroundColor(legendTextColor)
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
        .background(Color(UIColor.tertiaryLabel))
        .cornerRadius(22)
    }
}
