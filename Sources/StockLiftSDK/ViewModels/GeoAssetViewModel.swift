//
//  GeoAssetViewModel.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/7/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import Foundation

final class GeoAssetViewModel: BaseViewModel {
    let usersAssets: [GeoAssetsData]
    
    init(usersAssets: [GeoAssetsData]) {
        self.usersAssets = usersAssets
    }
}
