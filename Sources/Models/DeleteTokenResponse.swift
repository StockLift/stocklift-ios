//
//  DeleteTokenResponse.swift
//  Stocklift
//
//  Created by Christopher Hicks on 1/13/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public struct DeleteTokenResponse: Codable {
    public let success: Bool
    
    public init(success: Bool) {
        self.success = success
    }
}
