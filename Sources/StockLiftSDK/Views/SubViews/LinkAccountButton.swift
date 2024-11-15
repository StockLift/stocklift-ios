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
    
    @State private var isLoading: PlaidLoadState = .loading
    
    var body: some View {
//        Group {
//            if isLoading == .loaded {
                Text(linkAccountButtonText)
                    .font(linkAccountButtonFont)
                    .foregroundColor(linkAccountButtonFontColor)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 16)
                    .background(linkAccountButtonColor)
                    .contentShape(.capsule)
                    .clipShape(.capsule)
//            } else {
//                EmptyView()
//            }
//            switch isLoading {
//            case .loading:
//                EmptyView()
//            case .loaded:
//                Text(linkAccountButtonText)
//                    .font(linkAccountButtonFont)
//                    .foregroundColor(linkAccountButtonFontColor)
//                    .padding(.vertical, 3)
//                    .padding(.horizontal, 16)
//                    .background(linkAccountButtonColor)
//                    .contentShape(.capsule)
//                    .clipShape(.capsule)
//            case .failed:
//                EmptyView()
//                    .onAppear {
//                        print("Error in getting Plaid Link Token. Did you configure your access token?")
//                    }
//            }
//        }
        .onAppear { getPlaidLinkUrl() }

    }
    
    private func getPlaidLinkUrl () {
        PlaidViewModel.getPlaidLinkToken { isLoading in
            DispatchQueue.main.async {
                self.isLoading = isLoading
            }
        }
    }
}

