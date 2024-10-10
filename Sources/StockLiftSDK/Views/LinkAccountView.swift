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
    
    var body: some View {
        Group {
            switch isLoading {
            case .loading:
                ProgressView()
            case .loaded:
                VStack(alignment: .center, spacing: 24) {
                    VStack(spacing: 16) {
                        if #available(iOS 16.0, *) {
                            // ALLOWS Font Kerning
                            Text(linkAccountHeader)
                                .multilineTextAlignment(.center)
                                .appFontMedium()
                                .kerning(1.5)
                        } else {
                            Text(linkAccountHeader)
                                .multilineTextAlignment(.center)
                                .appFontMedium()
                        }
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
