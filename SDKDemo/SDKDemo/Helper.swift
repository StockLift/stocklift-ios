//
//  Helper.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/15/24.
//

import SwiftUI

struct HelperClass {
    
    static func randomColor() -> Color {
        let color = UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
        return Color(color)
    }
    
    static func randomTitle() -> String {
        let titles: [String] = ["Growth Chart", "Projections Data", "Portfolio Growth Projections", "More Data"]
        return titles.randomElement()!
    }
    
    static func randomConnectAccountTitle() -> String {
        let titles: [String] = ["Link your accounts!", "Connect your accounts!", "Add a brokerage account to get a free detailed breakdown of your investments"]
        return titles.randomElement()!
    }
    
}


// HELPER Extension
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
