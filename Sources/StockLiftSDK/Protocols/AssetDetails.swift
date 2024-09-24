//
//  AssetDetails.swift
//  Stocklift
//
//  Created by Christopher Hicks on 3/15/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public protocol AssetDetails {
    var sectors: [SectorTotals] { get }
    var equities: [[UserEquity]] { get }
    var funds: [[UserEquity]] { get }
}
