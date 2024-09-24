//
//  GrowthChartViewModel.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI

@available(iOS 13.0, *)
final class GrowthChartViewModel: BaseViewModel {
    
    @Published var hasAccountConnected: Bool = false
    @Published var growthChartEntries: [ChartData] = []
}
