//
//  EquityType.swift
//
//
//  Created by Christopher Hicks on 7/30/24.
//

import Foundation

public enum EquityType: String, Codable {
    case cash = "cash"
    case fixedIncome = "fixed income"
    case equity = "equity"
    case mutualFund = "mutual fund"
    case etf = "etf"
    case cryptocurrency = "cryptocurrency"
    case bonds = "bonds"
    case bond = "bond"
    case derivative = "derivative"
    
    public var title: String {
        switch self {
        case .cash:
            return self.rawValue
        case .fixedIncome:
            return self.rawValue
        case .equity:
            return self.rawValue
        case .mutualFund:
            return self.rawValue
        case .etf:
            return self.rawValue
        case .cryptocurrency:
            return self.rawValue
        case .bonds:
            return self.rawValue
        case .bond:
            return self.rawValue
        case .derivative:
            return self.rawValue
        }
    }
}
