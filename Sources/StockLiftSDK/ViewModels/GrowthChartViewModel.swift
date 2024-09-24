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
    
    override init() {
        Task { @MainActor in
            getGrowthChartData { chartData in
                self.growthChartEntries = chartData
            }
        }
    }
    
    @MainActor func getGrowthChartData(complete: @escaping @Sendable ([ChartData]) -> Void) {
        let uuid = "2jTIUY4T4TNZ71spCqwBsk9Zxpv2"
        NetworkService.shared.getGrowthChart(userUuid: uuid) { result in
            switch result {
                case .success(let res):
                complete(PortfolioChartUtils.setGrowthChart(res.data))
            case .failure(let err):
                print(err)
                complete([])
            }
        }
    }
}
