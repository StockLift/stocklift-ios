//
//  PlaidViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/4/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

//TODO: configure User Service
@available(iOS 13.0, *)
final class PlaidViewModel: BaseViewModel {
    
    /// Get Plaid Link Token
    static func getPlaidLinkToken() {
//        let defaults = UserDefaults.standard
//        UserService.shared.fetchLinkToken { result in
//            switch result {
//            case .success(let res):
//                let accounts = res.accounts
//                defaults.set(res.linkToken, forKey: UserKeys.linkToken)
//                do {
//                    try defaults.setObject(accounts, forKey: UserKeys.plaidAccounts)
//                } catch {
//                    print(error.localizedDescription)
//                }
//                
//            case .failure(let err):
//                print("[[ !!ERROR!! Getting plaid link token ]] \(err)")
//            }
//        }
    }
}


