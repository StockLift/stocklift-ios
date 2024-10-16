//
//  Portfolio.swift
//  Stocklift
//
//  Created by Christopher Hicks on 9/27/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import Foundation

public struct PortfolioResponse: Codable {
    public let hasAccount: Bool
    public let hasCostBasis: Bool?
    public let missingData: [String]?
    public let data: Portfolio
    public let pendingData: Bool?
    public let date: String?
    public let plaidError: PlaidError?
    
    public init(hasAccount: Bool, hasCostBasis: Bool?, missingData: [String]?, data: Portfolio, pendingData: Bool?, date: String?, plaidError: PlaidError? = nil) {
        self.hasAccount = hasAccount
        self.hasCostBasis = hasCostBasis
        self.missingData = missingData
        self.data = data
        self.pendingData = pendingData
        self.date = date
        self.plaidError = plaidError
    }
    
    enum CodingKeys: String, CodingKey {
        case hasAccount = "has_account"
        case hasCostBasis = "has_cost_basis"
        case missingData = "missing_data"
        case data
        case date = "date_connected"
        case pendingData = "pending_data"
        case plaidError = "plaid_error"
    }
}

public struct Portfolio: Codable {
    public let currentNetWorth: Float?
    public let totalHoldings: [UserEquity]
    public let sectorTotals: [SectorTotals]
    public let returnOnInvestment: String?
    public let diversificationScore: Float?
    public let totalGrowthAmount: [GrowthTimeline]
    public let geoAssets: [GeoAssetsData]
    
    public init(currentNetWorth: Float?, totalHoldings: [UserEquity], sectorTotals: [SectorTotals], returnOnInvestment: String?, diversificationScore: Float?, totalGrowthAmount: [GrowthTimeline], geoAssets: [GeoAssetsData]) {
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

public struct UserEquity: Codable, Identifiable {
    public let id: String
    public let name: String?
    public let symbol: String?
    public let institutionValue: Float?
    public var costBasis: Float?
    public let closePrice: Float?
    public let quantity: Decimal?
    public let sectors: [Sector]?
    public let type: EquityType?
    public let percentChange: Decimal?
    public let country: String?
    
    public init(id: String, name: String?, symbol: String?, institutionValue: Float?, costBasis: Float? = nil, closePrice: Float?, quantity: Decimal?, sectors: [Sector]?, type: EquityType?, percentChange: Decimal?, country: String?) {
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


public struct Sector: Codable, Identifiable, Hashable {
    public var id: String { sector ?? UUID().uuidString }
    public let sector: String?
    public let assetPercent: String?
    public let amountInvested: Float?
    
    public init(sector: String?, assetPercent: String?, amountInvested: Float?) {
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


public struct SectorTotals: Codable, Hashable, Identifiable {
    public var id: String { sector ?? UUID().uuidString }
    public let sector: String?
    public let amount: Float?
    public let percent: Float?
    public let percentChange: String?
    public let dollarChange: Float?
    
    public init(sector: String?, amount: Float?, percent: Float?, percentChange: String?, dollarChange: Float?) {
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


public struct GrowthTimeline: Codable {
    public let amount: Float?
    public let year: String?
    
    public init(amount: Float?, year: String?) {
        self.amount = amount
        self.year = year
    }
}
