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
    var linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments"
    
    @State private var isLoading: PlaidLoadState = .loading
    
    private var HeaderView: some View {
        if #available(iOS 16.0, *) {
            // ALLOWS Font Kerning
            return Text(linkAccountHeader)
                .multilineTextAlignment(.center)
                .appFontMedium()
                .kerning(1.5)
        } else {
            return Text(linkAccountHeader)
                .multilineTextAlignment(.center)
                .appFontMedium()
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
                                .frame(width: 44, height: 44)
                                .background(foregroundColor)
                                .foregroundColor(backgroundColor)
                                .clipShape(Circle())
                        }
                        .padding()
                        .appBorderOverlay(borderColor: .yellow)
                    }
                }
                //                .padding()
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
