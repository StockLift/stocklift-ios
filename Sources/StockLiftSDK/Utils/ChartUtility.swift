//
//  PortfolioChartUtils.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/18/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
class ChartUtility {
    
    // Pairing each sector with color for representation in a pie chart. Converts sector data into pie chart
    static func entriesForDiversification(_ entries: [SectorData], colors: [Color]) -> [PieChartData] {
        let combined = zip(entries, colors)
        let final = combined.map { (totals: SectorData, color: Color)  in
            PieChartData(value: totals.value, label: totals.label, color: color)
        }
        return final
        
    }
    
    // Create Pie Chart Entry for Sectors
    static func createEntry(title: String, total: Float) -> SectorData {
        let entry = SectorData(value: Double(total), label: title)
        return entry
    }
    
    // Convert sector data into an array of SectorData objects
    static func setSectorData(_ sectors: [SectorTotals]) -> [SectorData] {
        var sectorEntries: [SectorData] = []
        sectors.forEach { sector in
            let name = sector.sector
            let cleanName = name?.replacingOccurrences(of: "_", with: " ")
            let capitalName = cleanName?.localizedCapitalized
            let total = sector.percent ?? 0
            sectorEntries.append(ChartUtility.createEntry(title: capitalName ?? "", total: total))
        }
        return sectorEntries.sorted(by: {$0.value > $1.value})
    }
    
    static func setGrowthChart(_ data: [GrowthTimeline]) -> [ChartData] {
        return data.map { entry in
            let date: Date = entry.year?.toDate(format: "yyyy") ?? Date()
            var dateString = date.getFormattedDate(format: "yyyy")
            let currentYear = Date().getFormattedDate(format: "yyyy")
            if dateString == currentYear {
                dateString = Date().getFormattedDate(format: "MMM d")
            }
            return  ChartData(date: dateString, value: Double(entry.amount ?? 0))
        }
    }
    
    static func setSectorDetails(_ holdings: [UserEquity], with sectorTotals: [SectorTotals]) -> [[SectorTotals: [UserEquity]]] {
        var assetDict = [String: [UserEquity]]()
        var userDict = [[SectorTotals: [UserEquity]]]()
        
        holdings.forEach { userEquity in
            userEquity.sectors?.forEach({ sector in
                if sector.amountInvested != 0 {
                    var sectorName = ""
                    if sector.sector == "realestate" {
                        sectorName = "real estate"
                    }
                    else {
                        sectorName = sector.sector?.replacingOccurrences(of: "_", with: " ").lowercased() ?? ""
                    }
                    
                    if assetDict[sectorName] != nil {
                        assetDict[sectorName]?.append(userEquity)
                    } else {
                        assetDict[sectorName] = [userEquity]
                    }
                }
                
            })
        }
        
        var sortedDict = assetDict.sorted(by: { $0.key < $1.key })
        var otherAccount: [String: [UserEquity]] = [:]
        var cashAccount: [String: [UserEquity]] = [:]
        var cryptoAccount: [String: [UserEquity]] = [:]
        
        sortedDict.forEach { dict in
            if dict.key == "cash" {
                cashAccount[dict.key] = dict.value
                sortedDict.removeAll(where: { $0.key == "cash" })
            }
            
            if dict.key == "crypto" {
                cryptoAccount[dict.key] = dict.value
                sortedDict.removeAll(where: { $0.key == "crypto" })
            }
            
            if dict.key == "other" {
                otherAccount[dict.key] = dict.value
                sortedDict.removeAll(where: { $0.key == "other" })
            }
        }
        
        sortedDict.append(contentsOf: otherAccount)
        sortedDict.append(contentsOf: cashAccount)
        sortedDict.append(contentsOf: cryptoAccount)
        
        sortedDict.forEach { (dict) in
            let name = dict.key
            for  sectorData in sectorTotals {
                if sectorData.sector?.replacingOccurrences(of: "_", with: " ") == name {
                    let sector = SectorTotals(sector: name, amount: sectorData.amount, percent: sectorData.percent, percentChange: sectorData.percentChange, dollarChange: sectorData.dollarChange)
                    let equites = dict.value
                    let entry = [sector: equites]
                    userDict.append(entry)
                }
            }
        }
        
        return userDict
        
    }
    
    // Convert an array of UserEquity objects into dict: keys - stock symbols, values - tuples with closing price and total value
    static func makeDict(_ assets: [UserEquity]) -> [String: (close: Float, value: Float)] {
        var dict: [String: (close: Float, value: Float)] = [:]
        assets.forEach { equity in
            if equity.type != .cash {
                let key = equity.symbol ?? ""
                let close = Float(equity.closePrice ?? 0)
                let value = (Float("\(equity.quantity ?? 0)") ?? 0) * (equity.closePrice ?? 0)
                dict[key] = (close, value)
            }
        }
        return dict
    }
    
    // Checks if the only sector is "Cash"
    static func onlyCash(_ entries: [SectorData]) -> Bool {
        let count = entries.count
        let hasCash = entries.contains(where: { $0.label == "Cash" || $0.label == "cash" })
        if count == 1 && hasCash {
            return true
        } else {
            return false
        }
    }
    
    // Formats amount to String
    static func amount(_ entryValue: Double) -> String {
        var string = String(format: "%.2f", entryValue)
        string.append("%")
        return string
    }
    
    // Returns last 7 sorted, processed chart data points
    static func setCharts(entryData: [UserTimeSeries]) -> [ChartData] {
        let revEntries = entryData.reversed()
        var entries: [ChartData] = []
        
        revEntries.forEach { data in
            let x = data.value ?? 0
            let y = Double(1000 * x).rounded() / 1000
            let date = data.date?.getDateFromTimeSeries ?? Date()
            let stringDate = date.iso8601
            let value: Double = y
            let dataEntry = ChartData(date: stringDate, value: value)
            entries.append(dataEntry)
        }
        
        var limitedEntries = Array(entries.prefix(7))
        limitedEntries.sort(by: { $0.date < $1.date })
        return limitedEntries
    }
    
}
