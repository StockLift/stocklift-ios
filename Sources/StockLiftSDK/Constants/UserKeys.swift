//
//  UserKeys.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/24/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

//TODO: - finish setup
enum UserKeys: Identifiable, CaseIterable {
    public var id: String { "\(self)" }
    
    public static let linkToken = "co.stocklift_linkToken"
//    public static let userUuid = "co.sdk.stocklift_useruid"
//    public static let userObj = "co.sdk.stocklift_stock_lift_user"
//    public static let plaidAccounts = "co.stocklift_plaid_accounts"
}




