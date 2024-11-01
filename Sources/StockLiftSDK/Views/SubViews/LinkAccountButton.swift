//
//  LinkAccountButton.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 11/1/24.
//

import SwiftUI

struct LinkAccountButton: View {
    let linkAccountButtonText: String
    let linkAccountButtonFont: Font
    let linkAccountButtonFontColor: Color
    let linkAccountButtonColor: Color
    
    var body: some View {
        Text(linkAccountButtonText)
            .font(linkAccountButtonFont)
            .foregroundColor(linkAccountButtonFontColor)
            .padding(.vertical, 3)
            .padding(.horizontal, 16)
            .background(linkAccountButtonColor)
            .contentShape(.capsule)
            .clipShape(.capsule)
    }
}

