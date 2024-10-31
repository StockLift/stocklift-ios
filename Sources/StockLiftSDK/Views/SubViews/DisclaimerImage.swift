//
//  DisclaimerImage.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/28/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DisclaimerImage: View {
    @Binding var showDisclaimer: Bool
    let headerFontColor: Color
    var body: some View {
        Image(systemName: ImageKeys.infoCircle)
            .font(.caption2)
            .foregroundStyle(headerFontColor.opacity(0.4))
            .onTapGesture { withAnimation(.easeInOut) {showDisclaimer.toggle()} }
            .offset(x: 18)
    }
}

