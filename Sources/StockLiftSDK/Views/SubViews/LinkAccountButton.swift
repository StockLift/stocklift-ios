//
//  LinkAccountButton.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 11/1/24.
//

import SwiftUI

public struct LinkAccountButton: View {
    var linkAccountButtonText: String
    var linkAccountButtonFont: Font
    var linkAccountButtonFontColor: Color
    var linkAccountButtonColor: Color
    
    public init
    (
        linkAccountButtonText: String = "Link Account",
        linkAccountButtonFont: Font = .caption,
        linkAccountButtonFontColor: Color = .white,
        linkAccountButtonColor: Color = .blue
    ) {
        self.linkAccountButtonText = linkAccountButtonText
        self.linkAccountButtonFont = linkAccountButtonFont
        self.linkAccountButtonFontColor = linkAccountButtonFontColor
        self.linkAccountButtonColor = linkAccountButtonColor
    }
    
    public var body: some View {
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

