//
//  Haptic.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI

/// Haptic

struct HapticTap {
    static let medium = UIImpactFeedbackGenerator(style: .medium)
    static let light = UIImpactFeedbackGenerator(style: .light)
    static let heavy = UIImpactFeedbackGenerator(style: .heavy)
}
