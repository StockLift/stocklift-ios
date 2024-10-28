//
//  PortfolioViewModel.swift
//  Plaid-CloudFunctions
//
//  Created by Christopher Hicks on 7/22/22.
//

import SwiftUI
//import MapKit

@available(iOS 13.0, *)
final class PortfolioViewModel: BaseViewModel {
    
    @Published var isLoading: Bool = true
    @Published var hasCostBasis: Bool = true
    @Published var dateConnected: String = ""
    @Published var hasAccountConnected = false
//    @Published var missingData = [String]()
    @Published var missingSymbols: Int = 0
//    @Published var plaidError: PlaidError? = nil
//    @Published var showPlaidError: Bool = true

    
    @Published var userEquityAccounts: [UserEquity]? = nil
    @Published var sectorDetails: [[SectorTotals: [UserEquity]]] = []
    @Published var netWorth: Float? = nil
    @Published var percentChangeInPortfolio: String? = nil
    @Published var portfolioUpOrDown: Bool = false
    @Published var diversificationScore: Float? = nil
    @Published var returnOnInvestment: String? = nil
    @Published var returnUpOrDown: Bool = false
    
    /// CHARTS
    @Published var sectorEntries: [SectorData]? = nil
    @Published var growthChartEntries: [ChartData]? = nil
    @Published var userTopHoldings: [TopHoldingAsset]? = nil
    @Published var assetCoordinates: [AssetCoordinates]? = nil
    @Published var geoAssets: [GeoAssetsData]? = nil
    @Published var sp500ChartEntries: [ChartData]? = nil
    @Published var portfolioChartEntries: [ChartData]? = nil
    
    /// PLAID
//    @Published var linkedAccounts: [LinkedAccount] = []
//    var institutionName: String?
//    var instutionId: String?
    
//    override init(types: [SLChartType]) {
//        super.init()
//        initView()
//    }
    
    //MARK: Init
    func initView(types: [SLChartType]) {
        getPortfolio()
        if types.contains(.benchmark) {
            getBenchmarkChartData()
        }
        if types.contains(.geoDiversification) {
            getAssetMapData()
        }
    }
    
    static public func missingCostBasisMessage(_ date: String) -> String {
        let date: Date = date.toDate() ?? Date()
        let formattedDate = date.getFormattedDate(format: "MMM d, yyyy HH:mm")
        let message = "Returns for investments without cost basis are calculated from the date asset was detected on \(formattedDate)"
        return message
    }

    //MARK: - GET PORTFOLIO
    private func getPortfolio() {
        guard let client = StockLiftSDK.client else {
            fatalError(SLError.errorMessage(.clientDetailsNotSet))
        }
        self.isLoading = true
        NetworkService.shared.getPortfolio(clientId: client.uuid) { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.handleChartData(res)
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    self.isLoading = false
                    print(err)
                }
            }
        }
    }
    
    //MARK: - BENCHMARK CHART DATA - SP vs User Portfolio
    private func getBenchmarkChartData() {
        guard let client = StockLiftSDK.client else {
            fatalError(SLError.errorMessage(.clientDetailsNotSet))
        }
        NetworkService.shared.getBenchmarkChart(clientId: client.uuid) { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.setChartData(res)
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    //MARK: - ASSET LOCATION COORDINATES
    private func getAssetMapData() {
        guard let client = StockLiftSDK.client else {
            fatalError(SLError.errorMessage(.clientDetailsNotSet))
        }
        NetworkService.shared.getGeoDiversificationChart(clientId: client.uuid) { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.assetCoordinates = res.data.map { AssetCoordinates(name: $0.city ?? "",
                                                                           coordinate: .init(latitude: $0.lat ?? 0, longitude: $0.lng ?? 0),
                                                                           url: $0.url,
                                                                           symbol: $0.symbol) }
                    self.missingSymbols = res.missingSymbols
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    //TODO: - Refactor duplicate method in OpenLinkButton view
    public func removeOldToken(err: PlaidError, complete: @escaping (Bool) -> Void) {
//        UserService.shared.removePlaidAccountWithError(id: err.instId) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    complete(true)
//                }
//            case .failure(let err):
//                self.handleAlert(err: err, codeSheet: "PortfolioVM+removeOldToken") {
//                    complete(false)
//                    print(err)
//                }
//            }
//        }
    }
}

//MARK: - Handler Extensions
@available(iOS 13.0, *)
extension PortfolioViewModel {
    
    // SET MAIN Portfolio Response
    private func handleChartData(_ res: PortfolioResponse) {
        let hasAccount = res.hasAccount
//        if let error = res.plaidError {
//            self.plaidError = error
//        }
        if hasAccount {
            self.hasAccountConnected = hasAccount
            self.setPortfolioData(res.data)
            self.userTopHoldings = PortfolioViewModel.setTopHoldings(res.data.totalHoldings)
            self.geoAssets = res.data.geoAssets
            if let hasCostBasis = res.hasCostBasis {
                self.hasCostBasis = hasCostBasis
            }
            if let missingData = res.missingData {
//                self.missingData.removeAll()
//                self.missingData = missingData
                self.dateConnected = res.date ?? ""
            }
        } else {
            self.userEquityAccounts = nil
            self.isLoading = false
        }
    }
    
    // SET CHART DATA - Sector & Growth Charts
    private func setPortfolioData(_ portfolio: Portfolio) {
        userEquityAccounts = portfolio.totalHoldings
        netWorth = portfolio.currentNetWorth ?? 0
        diversificationScore = portfolio.diversificationScore ?? 0
        returnOnInvestment = portfolio.returnOnInvestment ?? ""
        let returnChange = portfolio.returnOnInvestment
        if returnChange?.first == "-" {
            returnUpOrDown = false
        } else {
            returnUpOrDown = true
        }
        // Sector Chart
        sectorEntries = PortfolioChartUtils.setSectorData(portfolio.sectorTotals)
        // Growth Chart
        growthChartEntries = PortfolioChartUtils.setGrowthChart(portfolio.totalGrowthAmount)
        // Sector Details
        sectorDetails = PortfolioChartUtils.setSectorDetails(portfolio.totalHoldings, with: portfolio.sectorTotals)
        isLoading = false
    }
    
    // SET CHART DATA - Benchmark Chart
    private func setChartData(_ res: PortfolioChartResponse) {
        self.portfolioChartEntries = PortfolioChartUtils.setCharts(entryData: res.portfolioTimeSeries)
        self.sp500ChartEntries = PortfolioChartUtils.setCharts(entryData: res.spTimeSeries)
        self.percentChangeInPortfolio = res.portfolioChange ?? ""
        let portfolioChange = res.portfolioChange ?? ""
        if portfolioChange.first == "-" {
            self.portfolioUpOrDown = false
        } else {
            self.portfolioUpOrDown = true
        }
    }
    

    
}



extension PortfolioViewModel {
    //MARK: SORT Top Holdings
    public static func setTopHoldings(_ holdings: [UserEquity], type: SortTopHoldingType = .weight) -> [TopHoldingAsset] {
        var rank = 0
        switch type {
        case .weight:
            let assets = holdings.sorted(by: {$0.institutionValue ?? 0 > $1.institutionValue ?? 0})
            return  assets.map { equity in
                rank += 1
                return TopHoldingAsset(holding: equity, rank: rank)
            }
        case .percentChange:
            let assets = holdings.sorted(by: {$0.percentChange ?? 0 > $1.percentChange ?? 0})
            return  assets.map { equity in
                rank += 1
                return TopHoldingAsset(holding: equity, rank: rank)
            }
        }

    }

}
