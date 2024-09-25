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
        super.init()
        getChartData()
    }
    
    func getChartData() {
        Task {
            await getGrowthChartData()
        }
    }
    
    private func getGrowthChartData() async {
        //TODO: set uuid
        let uuid = "2jTIUY4T4TNZ71spCqwBsk9Zxpv2"
        do {
            let data = try await NetworkService.shared.getGrowthChart(userUuid: uuid)
            DispatchQueue.main.async {
                self.growthChartEntries = PortfolioChartUtils.setGrowthChart(data)
                self.hasAccountConnected = self.growthChartEntries.isEmpty ? false : true
            }
        } catch {
            print(error)
        }
    }
}
