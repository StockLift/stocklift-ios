//
//  Portfolio.swift
//  Stocklift
//
//  Created by Christopher Hicks on 9/27/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import Foundation

struct PortfolioResponse: Codable {
    let hasAccount: Bool
    let hasCostBasis: Bool?
    let missingData: [String]?
    let data: Portfolio
    let pendingData: Bool?
    let date: String?
    
    init(hasAccount: Bool, hasCostBasis: Bool?, missingData: [String]?, data: Portfolio, pendingData: Bool?, date: String?) {
        self.hasAccount = hasAccount
        self.hasCostBasis = hasCostBasis
        self.missingData = missingData
        self.data = data
        self.pendingData = pendingData
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case hasAccount = "has_account"
        case hasCostBasis = "has_cost_basis"
        case missingData = "missing_data"
        case data
        case date = "date_connected"
        case pendingData = "pending_data"
    }
}

struct Portfolio: Codable {
    let currentNetWorth: Float?
    let totalHoldings: [UserEquity]
    let sectorTotals: [SectorTotals]
    let returnOnInvestment: String?
    let diversificationScore: Float?
    let totalGrowthAmount: [GrowthTimeline]
    let geoAssets: [GeoAssetsData]
    
    init(currentNetWorth: Float?, totalHoldings: [UserEquity], sectorTotals: [SectorTotals], returnOnInvestment: String?, diversificationScore: Float?, totalGrowthAmount: [GrowthTimeline], geoAssets: [GeoAssetsData]) {
        self.currentNetWorth = currentNetWorth
        self.totalHoldings = totalHoldings
        self.sectorTotals = sectorTotals
        self.returnOnInvestment = returnOnInvestment
        self.diversificationScore = diversificationScore
        self.totalGrowthAmount = totalGrowthAmount
        self.geoAssets = geoAssets
    }
    
    
    enum CodingKeys: String, CodingKey {
        case currentNetWorth = "current_net_worth"
        case totalHoldings = "total_holdings"
        case sectorTotals = "sector_totals"
        case returnOnInvestment = "return_on_investment"
        case diversificationScore = "diversification_score"
        case totalGrowthAmount = "total_growth_amount"
        case geoAssets = "geo_assets"
    }
}

struct UserEquity: Codable, Identifiable {
    let id: String
    let name: String?
    let symbol: String?
    let institutionValue: Float?
    var costBasis: Float?
    let closePrice: Float?
    let quantity: Decimal?
    let sectors: [Sector]?
    let type: EquityType?
    let percentChange: Decimal?
    let country: String?
    var url: URL?
    
    init(id: String, name: String?, symbol: String?, institutionValue: Float?, costBasis: Float? = nil, closePrice: Float?, quantity: Decimal?, sectors: [Sector]?, type: EquityType?, percentChange: Decimal?, country: String?, url: URL? = nil) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.institutionValue = institutionValue
        self.costBasis = costBasis
        self.closePrice = closePrice
        self.quantity = quantity
        self.sectors = sectors
        self.type = type
        self.percentChange = percentChange
        self.country = country
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case percentChange = "percent_change"
        case name, symbol, country
        case institutionValue = "institution_value"
        case costBasis = "cost_basis"
        case closePrice = "close_price"
        case quantity = "quantity"
        case sectors
        case type
        case id
    }
}


struct Sector: Codable, Identifiable, Hashable {
    var id: String { sector ?? UUID().uuidString }
    let sector: String?
    let assetPercent: String?
    let amountInvested: Float?
    
    init(sector: String?, assetPercent: String?, amountInvested: Float?) {
        self.sector = sector
        self.assetPercent = assetPercent
        self.amountInvested = amountInvested
    }
    
    enum CodingKeys: String, CodingKey {
        case sector
        case assetPercent = "asset_percent"
        case amountInvested = "amount_invested"
    }
}


struct SectorTotals: Codable, Hashable, Identifiable {
    var id: String { sector ?? UUID().uuidString }
    let sector: String?
    let amount: Float?
    let percent: Float?
    let percentChange: String?
    let dollarChange: Float?
    
    init(sector: String?, amount: Float?, percent: Float?, percentChange: String?, dollarChange: Float?) {
        self.sector = sector
        self.amount = amount
        self.percent = percent
        self.percentChange = percentChange
        self.dollarChange = dollarChange
    }
    
    enum CodingKeys: String, CodingKey {
        case sector, amount, percent
        case percentChange = "percent_change"
        case dollarChange = "total_dollar_change"
    }
}


struct GrowthTimeline: Codable {
    let amount: Float?
    let year: String?
    
    init(amount: Float?, year: String?) {
        self.amount = amount
        self.year = year
    }
}
