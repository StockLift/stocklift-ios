//
//  SectorCell.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/18/24.
//

import SwiftUI

struct SectorCell: View {
    let entry: PieChartData
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(entry.color)
                .frame(width: 8, height: 8)
            
            Text(PortfolioChartUtils.amount(entry.value))
                .appFontMedium(size: 16)
            
            Text(entry.label)
                .appFontRegular(size: 11)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.gray)
        .cornerRadius(22)
    }
}

