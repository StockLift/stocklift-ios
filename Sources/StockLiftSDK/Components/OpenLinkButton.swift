//
//  OpenLinkButton.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/24/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import LinkKit
import SwiftUI

struct OpenLinkButton<Content: View>: View {
    var showLoader: Bool = false
    var getPortfolio: () -> Void
    var errorHandler: () -> Void
    @ViewBuilder var content: Content
    
    @State private var linkToken: String?
    
    @State private var showLink = false
    @State private var isLoading: PlaidLoadState = .loading
    
    var body: some View {
        Button(action: {
            showLink = true
        }) {
            /// - VIEW CONTENT
            Group {
                if showLoader {
                    switch isLoading {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        content
                    case .failed:
                        EmptyView()
                            .onAppear {print("Error in getting Plaid Link Token. Did you configure your access token?")}
                    }
                } else {
                    content
                }
            }
            .onAppear { getPlaidLinkUrl() }
        }
        .sheet(isPresented: $showLink,
               onDismiss: {
            showLink = false
        }, content: {
            if let linkToken = linkToken {
                PlaidLinkFlow(
                    linkTokenConfiguration: createLinkTokenConfiguration(token: linkToken),
                    showLink: $showLink
                )
            }
        })
    }
    
    private func getPlaidLinkUrl () {
        PlaidViewModel.getPlaidLinkToken { (isLoading, linkToken) in
            DispatchQueue.main.async {
                self.isLoading = isLoading
                self.linkToken = linkToken
            }
        }
    }
    
    /// 1st - User Links account and gets plaid access token
    private func createLinkTokenConfiguration(token: String) -> LinkTokenConfiguration {
        var configuration = LinkTokenConfiguration(
            token: token,
            onSuccess: { success in
                let name = success.metadata.institution.name
                let id = success.metadata.institution.id
                let accounts: [PlaidAccount] = success.metadata.accounts.map {
                    PlaidAccount(id: "\($0.mask ?? "0000")_\(name)", name: $0.name, mask: $0.mask)
                }
                
                self.exchangeToken(token: success.publicToken,
                                   name: name,
                                   id: id,
                                   accounts: accounts)
            }
        )
        
        configuration.onEvent = { event in
            //   print("🆔 Link Event: \(event)")
        }
        
        configuration.onExit = { exit in
            if let error = exit.error {
                print("⛔️ exit with \(error)\n\(exit.metadata)")
            } else {
                print("⛔️ exit with \(exit.metadata)")
            }
            
            DispatchQueue.main.async { showLink = false }
        }
        
        return configuration
    }
}

private struct PlaidLinkFlow: View {
    @Binding var showLink: Bool
    private let linkTokenConfiguration: LinkTokenConfiguration
    init(linkTokenConfiguration: LinkTokenConfiguration, showLink: Binding<Bool>) {
        self.linkTokenConfiguration = linkTokenConfiguration
        self._showLink = showLink
    }
    var body: some View {
        let linkController = LinkController(
            configuration: .linkToken(linkTokenConfiguration)
        ) { createError in
            print("⛔️ Link Creation Error: \(createError)")
            self.showLink = false
        }
        return linkController
            .onOpenURL { url in
                linkController.linkHandler?.continue(from: url)
            }
    }
}


extension OpenLinkButton {
    /// 2nd - Exchange plaid token for public access token
    func exchangeToken(token: String, name: String, id: String, accounts: [PlaidAccount]) {
        /// - SLClient
        guard let client = StockLiftSDK.client else { fatalError(SLError.errorMessage()) }
        /// - Plaid Linked Account
        let linkAccount: PlaidLinkAccount = .init(
            token: token,
            name: name,
            id: id,
            accounts: accounts
        )
        /// Plaid Exchange Token Request
        PlaidViewModel.exchangeToken(
            client: client,
            linkAccount: linkAccount
        ) {
            /// - Hide Show Link View (Main View)
            showLink = false
            // GET PORTFOLIO
            DispatchQueue.main.async {
                getPortfolio()
            }
        }
    }
}
