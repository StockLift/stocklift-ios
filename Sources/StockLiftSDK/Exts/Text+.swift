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
                .font(.system(size: size, weight: .regular, design: .default))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
                .font(.system(size: size, weight: .regular, design: .default))
                .foregroundColor(color)
        }
    }
    
    func appFontMedium(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.system(size: size, weight: .medium, design: .default))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
                .font(.system(size: size, weight: .medium, design: .default))
                .foregroundColor(color)
        }
    }
    
    func appFontBold(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.system(size: size, weight: .bold, design: .default))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
                .font(.system(size: size, weight: .bold, design: .default))
                .foregroundColor(color)
        }
    }
    
    func appFontBlack(size: CGFloat = 14, color: Color = .white) -> some View {
        if #available(iOS 14.0, *) {
            self
                .font(.system(size: size, weight: .black, design: .default))
                .foregroundColor(color)
        } else {
            // Fallback on earlier versions
            self
                .font(.system(size: size, weight: .black, design: .default))
                .foregroundColor(color)
        }
    }
}
