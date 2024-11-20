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
    static let linkToken = "co.stocklift_sdk_linkToken"
    static let viewState = "co.stocklift_sdk_viewState"
}




