//
//  Helper.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/15/24.
//

import SwiftUI

struct HelperClass {
    
    static func randomColor() -> Color {
        let colors: [Color] = [.blue, .red, .yellow, .green, .blue, .purple, .pink, .orange, .gray, .green, .clear]
        return colors[.random(in: 0..<colors.count)]
    }
    
    static func randomFontColor() -> Color {
        let colors: [Color] = [.blue, .blue, .purple]
        return colors[.random(in: 0..<colors.count)]
    }
    
    static func randomLgFont() -> Font {
        let fonts: [Font] = [.body, .headline, .largeTitle, .title, .title2, .title3]
        return fonts[.random(in: 0..<fonts.count)]
    }
    
    static func randomSmFont() -> Font {
        let fonts: [Font] = [.callout, .caption, .caption2, .footnote, .subheadline]
        return fonts[.random(in: 0..<fonts.count)]
    }
    
    static func randomTitle() -> String {
        let titles: [String] = ["Growth Chart", "Projections Data", "Portfolio Growth Projections", "Top Holdings", "Portfolio Breakdown", "My Portfolio vs. SP 500"]
        return titles.randomElement()!
    }
    
    static func randomConnectAccountTitle() -> String {
        let titles: [String] = ["Link your accounts!", "Connect your accounts!", "Add a brokerage account to get a free detailed breakdown of your investments"]
        return titles.randomElement()!
    }
    
    // Method will return a random Int between 150 - 350
    static func randomHeight() -> CGFloat {
        return CGFloat.random(in: 150...350)
    }
    
    static func randomCornerRadius() -> CGFloat {
        return CGFloat.random(in: 10...20)
    }
    
    static func randomShadowBool() -> Bool {
        let bools: [Bool] = [true, false]
        return bools.randomElement()!
    }
    
}


// HELPER Extension
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


struct TemplateDemoView<T:View>: View {
    @ViewBuilder let content: T
    let data = (1...5)
    let columns = [
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(data, id: \.self) { _ in
                    content
                    .padding(CGFloat(Int.random(in: 4...25)))
                }
            }
        }
    }
}
