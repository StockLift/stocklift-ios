//
//  Text+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI

@available(iOS 13.0, *)
public extension Text {
    
    func appFontRegular(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.custom(FONT_REGULAR, fixedSize: size))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
        }
    }
    
    func appFontMedium(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.custom(FONT_MEDIUM, fixedSize: size))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
        }
    }
    
    func appFontBold(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.custom(FONT_BOLD, fixedSize: size))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
        }
    }
    
    func appFontBlack(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.custom(FONT_BLACK, fixedSize: size))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
        }
    }
}
