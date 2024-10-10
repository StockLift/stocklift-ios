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
    @Binding var plaidAccountError: PlaidError?
    @ViewBuilder var content: Content
    
    @State private var showLink = false
    
    private let defaults = UserDefaults.standard
    private var token: String {
        defaults.string(forKey: UserKeys.linkToken) ?? "error_could_not_get_link_token"
    }
    private var userUuid: String? {
        defaults.string(forKey: UserKeys.userUuid)
    }


    var body: some View {
        Button(action: {
            showLink = true
        }) {
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
    
    private func userAccounts() -> [PlaidAccount]? {
        do {
            let accounts = try self.defaults.getObject(forKey: UserKeys.plaidAccounts, castTo: [PlaidAccount].self)
            return accounts
        } catch {
            print(error.localizedDescription)
        }
        
        return []
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
                
                
//                let alreadyConnectedAccounts = self.userAccounts()
//                var duplicateError = false
//                alreadyConnectedAccounts?.forEach { account in
//                    let match = accounts.contains { "\($0.mask ?? "0000")_\(name)" == account.id }
//                    if match == true && plaidAccountError == nil {
//                        // ERROR can not connect same account twice
//                        duplicateError = true
//                        showLink = false
//                        errorHandler()
//                    }
//                }
//                if duplicateError == true {
//                    // ERROR can not connect same account twice
//                    showLink = false
//                    errorHandler()
//                } else {
//                print(success)
                self.exchangeToken(token: success.publicToken,
                                       name: name,
                                       id: id,
                                       accounts: accounts,
                                       plaidError: plaidAccountError)
//                    FBAnalytics.shared.logEvent(name: .connectedPlaid)
                    showLink = false
//                }
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
    func exchangeToken(token: String, name: String, id: String, accounts: [PlaidAccount], plaidError: PlaidError?) {
        /// - SLClient
        guard let client = StockLiftSDK.client else { fatalError(SLError.errorMessage("Remember to set the client details before connecting accounts.")) }
        /// - Plaid Linked Account
        let linkAccount: PlaidLinkAccount = .init(
            token: token,
            name: name,
            id: id,
            accounts: accounts
        )
        PlaidViewModel.exchangeToken(
            client: client,
            linkAccount: linkAccount
        )
        
        //        UserService.shared.exchangeToken(publicToken: token, name: institutionName, id: instutionId, accounts: accounts) { result in
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    if let error = plaidError {
//                        self.removeOldToken(err: error)
//                    } else {
//                        getPortfolio()
//                    }
//                }
//            case .failure(let error):
//                print("⛔️ ERROR: Getting Access Token ⛔️\n\(error.localizedDescription)")
//                FBAuth.sendSlackMessage(codeSheet: "Exchange Token Plaid",
//                                      message: "\(error.rawValue)",
//                                      data: "UUID: \(userUuid ?? "")")
//            }
//        }
    }
    
    private func removeOldToken(err: PlaidError) {
//        UserService.shared.removePlaidAccountWithError(id: err.instId) { result in
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    self.plaidAccountError = nil
//                    getPortfolio()
//                }
//            case .failure(let err):
//                print("⛔️ ERROR: Removing Old Token ⛔️\n\(err.rawValue)")
//                FBAuth.sendSlackMessage(codeSheet: "OpenLinkButton+removeOldToken",
//                                        message: "\(err.rawValue)",
//                                        data: "UUID: \(userUuid ?? "")")
//                
//            }
//        }
    }
}
