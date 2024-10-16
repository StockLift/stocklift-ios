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
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            HStack(alignment: .center, spacing: 4) {
                Circle().fill(Color.yellow)
                    .frame(width: 8, height: 8)
                Text("My Portfolio")
                    .appFontMedium(size: 12)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.yellow)
            .cornerRadius(22)
            
            HStack(alignment: .center, spacing: 4) {
                Circle().fill(Color.blue)
                    .frame(width: 8, height: 8)
                Text("S&P 500")
                    .appFontMedium(size: 12)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.gray)
            .cornerRadius(22)
        }
        .padding(.top)
        .padding(.bottom, 28)
    }
}
