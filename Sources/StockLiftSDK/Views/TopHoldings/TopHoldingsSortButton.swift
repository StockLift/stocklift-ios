//
//  TopHoldingsSortButton.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/1/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

struct TopHoldingsSortButton: View {
    @Binding var sortViewState: SortTopHoldingType
    
    var body: some View {
        HStack {
            Text(sortViewState.toggleTitle)
            Image(systemName: "chevron.down")
        }
//        .appFontBold(size: 14, color: .)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.yellow)
        .clipShape(.capsule)
        .contentShape(Capsule())
        .padding(.horizontal, 34)
        .padding(.vertical)
        .onTapGesture {
            switch sortViewState {
            case .weight:
                withAnimation(.easeInOut) {sortViewState = .percentChange}
            case .percentChange:
                withAnimation(.easeInOut) {sortViewState = .weight}
            }
        }
    }
}
