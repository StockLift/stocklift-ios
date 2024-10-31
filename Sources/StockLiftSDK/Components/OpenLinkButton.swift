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
    var getPortfolio: () -> Void
    var errorHandler: () -> Void
    @ViewBuilder var content: Content
    
    private var token: String {
        UserDefaults.standard.string(forKey: UserKeys.linkToken) ?? "error_could_not_get_link_token"
    }

    @State private var showLink = false

    var body: some View {
        Button(action: {
            showLink = true
        }) {
            /// - VIEW CONTENT
           content
        }
        .sheet(isPresented: $showLink,
            onDismiss: {
                showLink = false
            }, content: {
                PlaidLinkFlow(
                    linkTokenConfiguration: createLinkTokenConfiguration(),
                    showLink: $showLink
                )
            }
        )
    }

    /// 1st - User Links account and gets plaid access token
    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        var configuration = LinkTokenConfiguration(
            token: self.token,
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
