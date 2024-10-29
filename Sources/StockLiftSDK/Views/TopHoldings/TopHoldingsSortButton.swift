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
    let fontColor: Color // white
    let buttonColor: Color // blue
    let buttonFont: Font // caption
    
    var body: some View {
        HStack {
            Text(sortViewState.toggleTitle)
            Image(systemName: "chevron.down")
        }
        .font(buttonFont)
        .foregroundColor(fontColor)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(buttonColor)
        .clipShape(.capsule)
        .contentShape(Capsule())
        .padding(.horizontal, 34)
        .padding(.bottom, 8)
//        .padding(.vertical)
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
