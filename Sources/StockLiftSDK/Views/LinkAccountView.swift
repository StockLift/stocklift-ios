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
    @ObservedObject var portfolioVM: PortfolioViewModel
    let plaidError: () -> Void
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack(alignment: .center, spacing: 24) {
                VStack(spacing: 16) {
                    Text("Add a brokerage account to get a free detailed breakdown of your investments")
                        .multilineTextAlignment(.center)
                        .appFontMedium()
                        .kerning(1.5)
                }
                .padding()
                .appBorderOverlay(borderColor: .appYellow)
                
                //TODO: - config Plaid
//                OpenLinkButton(getPortfolio: portfolioVM.initView, errorHandler: plaidError, plaidAccountError: .constant(nil)) {
//                    Image(systemName: ImageKeys.plusCircleFill)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 44, height: 44)
//                        .background(Color.white)
//                        .foregroundColor(Color.appYellow)
//                        .clipShape(Circle())
//                }
            }
            .onAppear { PlaidViewModel.getPlaidLinkToken() }
            .padding()
            
        } else {
            Text("Update your phone please")
                .appFontBold()
        }
    }
}
