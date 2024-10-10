//
//  LinkAccountView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/12/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI


@available(iOS 13.0, *)
struct LinkAccountView: View {
    let plaidError: () -> Void
    let getPortfolio: () -> Void
    var foregroundColor: Color = .white
    var backgroundColor: Color = .yellow
    
    var body: some View {
        // ALLOWS Font Kerning
        if #available(iOS 16.0, *) {
            VStack(alignment: .center, spacing: 24) {
                VStack(spacing: 16) {
                    Text("Add a brokerage account to get a free detailed breakdown of your investments")
                        .multilineTextAlignment(.center)
                        .appFontMedium()
                        .kerning(1.5)
                }
                .padding()
                .appBorderOverlay(borderColor: .yellow)
                
                // Plaid Link flow
                OpenLinkButton(getPortfolio: getPortfolio, errorHandler: plaidError, plaidAccountError: .constant(nil)) {
                    Image(systemName: ImageKeys.plusCircleFill)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .background(foregroundColor)
                        .foregroundColor(backgroundColor)
                        .clipShape(Circle())
                }
            }
            .onAppear { PlaidViewModel.getPlaidLinkToken() }
            .padding()
            
        } else {
            VStack(alignment: .center, spacing: 24) {
                VStack(spacing: 16) {
                    Text("Add a brokerage account to get a free detailed breakdown of your investments")
                        .multilineTextAlignment(.center)
                        .appFontMedium()
                }
                .padding()
                .appBorderOverlay(borderColor: .yellow)
                
                // Plaid Link flow
                OpenLinkButton(getPortfolio: getPortfolio, errorHandler: plaidError, plaidAccountError: .constant(nil)) {
                    Image(systemName: ImageKeys.plusCircleFill)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .background(foregroundColor)
                        .foregroundColor(backgroundColor)
                        .clipShape(Circle())
                }
            }
            .onAppear { PlaidViewModel.getPlaidLinkToken() }
            .padding()
        }
    }
}
