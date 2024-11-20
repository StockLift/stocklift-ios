//
//  LinkAccountView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/12/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LinkAccountView: View {
    var linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments"
    var plaidError: () -> Void
    var getPortfolio: () -> Void
    var foregroundColor: Color
    var backgroundColor: Color
    var borderColor: Color
    var connectSize: CGFloat
    var font: Font
    var fontColor: Color
    
    private var HeaderView: some View {
        if #available(iOS 16.0, *) {
            // ALLOWS Font Kerning
            return Text(linkAccountHeader)
                .multilineTextAlignment(.center)
                .font(font)
                .foregroundStyle(fontColor)
                .kerning(1.4)
        } else {
            return Text(linkAccountHeader)
                .multilineTextAlignment(.center)
                .font(font)
                .foregroundColor(fontColor)
        }
    }
    
    var body: some View {
        // Plaid Link flow
        OpenLinkButton(showLoader: true, getPortfolio: getPortfolio, errorHandler: plaidError) {
            VStack(alignment: .center, spacing: 24) {
                VStack(spacing: 16) {
                    HeaderView
                    Image(systemName: ImageKeys.plusCircleFill)
                        .resizable()
                        .scaledToFit()
                        .frame(width: connectSize, height: connectSize)
                        .background(backgroundColor)
                        .foregroundColor(foregroundColor)
                        .clipShape(Circle())
                }
                .padding()
                .appBorderOverlay(borderColor: borderColor, backgroundColor: backgroundColor)
            }
        }
    }
}
