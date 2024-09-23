//
//  SP500Sectors.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/5/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public enum SP500Sectors: Int {
    case energy
    case basicMaterials
    case industrials
    case consumerCyclical
    case consumerDefensive
    case healthCare
    case financialServices
    case technology
    case communicationServices
    case utilities
    case realEstate
    case crypto
    
    
    public var title: String {
        switch self {
        case .energy:
            return "Energy"
        case .basicMaterials:
            return "Basic\nMaterials"
        case .industrials:
            return "Industrials"
        case .consumerCyclical:
            return "Consumer\nCyclical"
        case .consumerDefensive:
            return "Consumer\nDefensive"
        case .healthCare:
            return "Health\nCare"
        case .financialServices:
            return "Financial\nServices"
        case .technology:
            return "Technology"
        case .communicationServices:
            return "Communication\nServices"
        case .utilities:
            return "Utilities"
        case .realEstate:
            return "Real\nEstate"
        case .crypto:
            return "Crypto"
        }
    }
}
