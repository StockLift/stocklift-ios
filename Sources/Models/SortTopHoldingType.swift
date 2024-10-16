//
//  SortTopHoldingType.swift
//
//
//  Created by Christopher Hicks on 8/19/24.
//

import Foundation

public enum SortTopHoldingType {
    case weight, percentChange
    
    public var toggleTitle: String {
        switch self {
        case .weight:
            return  "Weight"
        case .percentChange:
            return  "Performance"
        }
    }
}
