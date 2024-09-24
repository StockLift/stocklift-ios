//
//  PortfolioViewModel.swift
//  Plaid-CloudFunctions
//
//  Created by Christopher Hicks on 7/22/22.
//

import SwiftUI
import MapKit

//TODO: - setup network layer
@available(iOS 13.0, *)
final class PortfolioViewModel: BaseViewModel {
    
    @Published var isLoading: Bool = true
    @Published var isLoadingSim: Bool = true
    @Published var hasCostBasis: Bool = true
    @Published var missingData = [String]()
    @Published var dateConnected: String = ""
    @Published var hasAccountConnected = false
    @Published var hasConfirmedFidelityIssue: Bool = true
    @Published var missingSymbols: Int = 0
    @Published var plaidError: PlaidError? = nil
    @Published var showPlaidError: Bool = true

    
    @Published var userEquityAccounts: [UserEquity]?
    @Published var sectorDetails: [[SectorTotals: [UserEquity]]] = []
    @Published var netWorth: Float = 0
    @Published var percentChangeInPortfolio: String = "0.00"
    @Published var portfolioUpOrDown: Bool = false
    @Published var diversificationScore: Float = 0
    @Published var returnOnInvestment: String = "0.00"
    @Published var returnUpOrDown: Bool = false
    @Published var userTopHoldings: [TopHoldingAsset]? = nil
    @Published var assetCoordinates: [AssetCoordinates]? = nil
    @Published var geoAssets: [GeoAssetsData]? = nil
    
    /// CHARTS
    @Published var sectorEntries: [SectorData]?
    @Published var sp500ChartEntries: [ChartData] = []
    @Published var portfolioChartEntries: [ChartData] = []
    @Published var growthChartEntries: [ChartData] = []
    
    /// PLAID
    @Published var linkedAccounts: [LinkedAccount] = []
    var institutionName: String?
    var instutionId: String?
    
    override init() {
        super.init()
        getMarketStatus()
        initView()
    }
    
    //MARK: Init
    func initView() {
        getPortfolio()
        getPortfolioChart()
        getAssetMapData()
    }
    
    static public func missingCostBasisMessage(_ date: String) -> String {
        let date: Date = date.toDate() ?? Date()
        let formattedDate = date.getFormattedDate(format: "MMM d, yyyy HH:mm")
        let message = "Returns for investments without cost basis are calculated from the date asset was detected on \(formattedDate)"
        return message
    }

    /// GET PORTFOLIO
    private func getPortfolio() {
//        UserService.shared.getUserPortfolio { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let res):
//                DispatchQueue.main.async {
//                    let hasAccount = res.hasAccount
//                    if let error = res.plaidError {
//                        self.plaidError = error
//                    }
//                    if hasAccount {
//                        self.hasAccountConnected = hasAccount
//                        self.setPortfolioData(res.data)
//                        self.userTopHoldings = PortfolioViewModel.setTopHoldings(res.data.totalHoldings)
//                        self.geoAssets = res.data.geoAssets
//                        if let hasCostBasis = res.hasCostBasis {
//                            self.hasCostBasis = hasCostBasis
//                        }
//                        if let missingData = res.missingData {
//                            self.missingData.removeAll()
//                            self.missingData = missingData
//                            self.dateConnected = res.date ?? ""
//                        }
//                    } else {
//                        self.userEquityAccounts = nil
//                        self.isLoading = false
//                    }
//                }
//                
//                
//            case .failure(let err):
//                self.handleAlert(err: err, codeSheet: "Portfolio VM") {
//                    self.isLoading = false
//                }
//            }
//        }
    }
    
    private func getPortfolioChart() {
//        UserService.shared.getPortfolioChartData { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let res):
//                DispatchQueue.main.async {
//                    self.setChartData(res)
//                }
//            case .failure(let err):
//                self.handleAlert(err: err, codeSheet: "Portfolio VM") { }
//            }
//        }
    }
    
    
    //TODO: - REPLACE WITH STOCKLIFT API
    //MARK: - GET LINKED ACCOUNTS
    func getLinkedAccounts() {
//        guard let uid = self.currentUser?.uid else { return }
//        let ref = COLLECTION_USERS.document(uid).collection(FBKeys.CollectionPath.linkedAccounts)
//        ref.getDocuments { [weak self] snapshot, error in
//            guard let self = self else { return }
//            if let error = error {
//                print("ERROR: Getting linked accounts \(error)")
//            } else {
//                self.linkedAccounts.removeAll()
//                guard let docs = snapshot?.documents else { return }
//                docs.forEach { document in
//                    let data = document.data()
//                    if let account = LinkedAccount(documentData: data) {
//                        self.linkedAccounts.append(account)
//                        
//                    }
//                }
//            }
//        }
    }
}

@available(iOS 13.0, *)
extension PortfolioViewModel {
    
    //MARK: Set Data
    private func setPortfolioData(_ portfolio: Portfolio) {
//        defaults.set(false, forKey: UserKeys.connectFlow)
//        userEquityAccounts = portfolio.totalHoldings
//        netWorth = portfolio.currentNetWorth ?? 0
//        diversificationScore = portfolio.diversificationScore ?? 0
//        returnOnInvestment = portfolio.returnOnInvestment ?? ""
//        let returnChange = portfolio.returnOnInvestment
//        if returnChange?.first == "-" {
//            returnUpOrDown = false
//        } else {
//            returnUpOrDown = true
//        }
//        // Sector Chart
//        sectorEntries = PortfolioChartUtils.setSectorData(portfolio.sectorTotals)
//        // Growth Chart
//        growthChartEntries = PortfolioChartUtils.setGrowthChart(portfolio.totalGrowthAmount)
//        // Sector Details
//        sectorDetails = PortfolioChartUtils.setSectorDetails(portfolio.totalHoldings, with: portfolio.sectorTotals)
//        isLoading = false
    }
    
    private func setChartData(_ res: PortfolioChartResponse) {
//        self.portfolioChartEntries = PortfolioChartUtils.setCharts(entryData: res.portfolioTimeSeries)
//        self.sp500ChartEntries = PortfolioChartUtils.setCharts(entryData: res.spTimeSeries)
//        self.percentChangeInPortfolio = res.portfolioChange ?? ""
//        let portfolioChange = res.portfolioChange ?? ""
//        if portfolioChange.first == "-" {
//            self.portfolioUpOrDown = false
//        } else {
//            self.portfolioUpOrDown = true
//        }
    }

    // Checks Market Status
    private func getMarketStatus() {
//        UserService.shared.marketStatus { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let res):
//                DispatchQueue.main.async {
//                    self.isMarketOpen = res.isOpen
//                }
//            case .failure(let err):
//                self.handleAlert(err: err, codeSheet: "Portfolio VM") { }
//            }
//        }
    }
}



@available(iOS 13.0, *)
extension PortfolioViewModel {
    //MARK: SORT Top Holdings
    public static func setTopHoldings(_ holdings: [UserEquity], type: SortTopHoldingType = .weight) -> [TopHoldingAsset] {
        return [] //TODO: remove this line
//        var rank = 0
//        switch type {
//        case .weight:
//            let assets = holdings.sorted(by: {$0.institutionValue ?? 0 > $1.institutionValue ?? 0})
//            return  assets.map { equity in
//                rank += 1
//                return TopHoldingAsset(holding: equity, rank: rank)
//            }
//        case .percentChange:
//            let assets = holdings.sorted(by: {$0.percentChange ?? 0 > $1.percentChange ?? 0})
//            return  assets.map { equity in
//                rank += 1
//                return TopHoldingAsset(holding: equity, rank: rank)
//            }
//        }

    }
    
    //MARK: ASSET LOCATION COORDINATES
    private func getAssetMapData() {
//        UserService.shared.getAssetCoordinates { result in
//            switch result {
//            case .success(let res):
//                DispatchQueue.main.async {
//                    self.assetCoordinates = res.data.map { AssetCoordinates(name: $0.city ?? "",
//                                                                           coordinate: .init(latitude: $0.lat ?? 0, longitude: $0.lng ?? 0),
//                                                                           url: $0.url,
//                                                                           symbol: $0.symbol) }
//                    self.missingSymbols = res.missingSymbols
//                }
//            case .failure(let err):
//                self.handleAlert(err: err, codeSheet: "PortfolioVM+getAssetMapData") {
//                    print(err)
//                }
//            }
//        }
    }
}



@available(iOS 13.0, *)
extension PortfolioViewModel {
    // TODO: refactor - duplicate method in OpenLinkButton view
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
