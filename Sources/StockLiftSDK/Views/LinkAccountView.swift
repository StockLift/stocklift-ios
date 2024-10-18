//
//  LinkAccountView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/12/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI


@available(iOS 15.0, *)
struct LinkAccountView: View {
    var linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments"
    let plaidError: () -> Void
    let getPortfolio: () -> Void
    var foregroundColor: Color = .white
    var backgroundColor: Color = .yellow
    var borderColor: Color = .gray
    var borderBackgroundColor: Color = .black
    var connectSize: CGFloat = 38
    var font: Font = .body
    var fontColor: Color = .black
    
    @State private var isLoading: PlaidLoadState = .loading
    
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
                .foregroundStyle(fontColor)
        }
    }
    
    var body: some View {
        Group {
            switch isLoading {
            case .loading:
                ProgressView()
            case .loaded:
                // Plaid Link flow
                OpenLinkButton(getPortfolio: getPortfolio, errorHandler: plaidError, plaidAccountError: .constant(nil)) {
                    VStack(alignment: .center, spacing: 24) {
                        VStack(spacing: 16) {
                            HeaderView
                            Image(systemName: ImageKeys.plusCircleFill)
                                .resizable()
                                .scaledToFit()
                                .frame(width: connectSize, height: connectSize)
                                .background(foregroundColor)
                                .foregroundColor(backgroundColor)
                                .clipShape(Circle())
                        }
                        .padding()
                        .appBorderOverlay(borderColor: borderColor, backgroundColor: borderBackgroundColor)
                    }
                }
            case .failed:
                EmptyView()
                    .onAppear {
                        print("Error in getting Plaid Link Token. Did you configure your access token?")
                    }
            }
        }
        .onAppear { handPlaid() }
    }
    
    private func handPlaid () {
        PlaidViewModel.getPlaidLinkToken {  isLoading in
            DispatchQueue.main.async {
                self.isLoading = isLoading
            }
        }
    }
}
