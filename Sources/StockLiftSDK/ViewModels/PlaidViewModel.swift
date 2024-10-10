//
//  PlaidViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/4/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
final class PlaidViewModel: BaseViewModel {

    /// Get Plaid Link Token
    static func getPlaidLinkToken(isLoading: @escaping (PlaidLoadState) -> Void) {
        NetworkService.shared.getPlaidLinkToken { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.sync {
                    UserDefaults.standard.set(res.linkToken, forKey: UserKeys.linkToken)
                    isLoading(.loaded)
                }
            case .failure(let err):
                print(err)
                isLoading(.failed)
            }
        }
    }
}


