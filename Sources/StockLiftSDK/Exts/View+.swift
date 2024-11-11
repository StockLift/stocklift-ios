//
//  View+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import Kingfisher

@available(iOS 13.0, *)
extension View {
    //MARK: - CUSTOM DIVIDER
    var SLDivider: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color(UIColor.tertiaryLabel))
    }
    
    //MARK: - ENCODE DATE (string to date)
    func encodeDate(_ dateString: String) -> Date {
        if let date = dateString.toDateNoZone(format: "yyyy") {
            return date
        }
        else if let _ = dateString.toDateNoZone(format: "MM-d") {
            let newDate = Date()
            return newDate
        }
        else if let date = dateString.toDateNoZone(format: "E d") {
            return date
        }
        else if let date = dateString.toDateNoZone(format: "MMM d") {
            return date
        }
        else if let date = dateString.toDateNoZone(format: "MMM") {
            return date
        }
        else if let date = dateString.toDateEST(format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX") {
            return date
        }
        else {
            return Date()
        }
    }
    
    //MARK: - SET + or - symbol (gain or loss)
    func setSymbol(_ amount: String, insert: String? = nil) -> String {
        if amount.first == "-" {
            let newAmount = amount.dropFirst()
            if let insert = insert {
                return "-\(insert)\(newAmount)"
            } else {
                return "\(amount)"
            }
        } else {
            if let insert = insert {
                return "+\(insert)\(amount)"
            } else {
                return "+\(amount)"
            }
        }
    }
    
    //MARK: - CUSTOM BORDER
    func appBorderOverlay(radius: CGFloat = 20,
                          lineWidth: CGFloat = 2,
                          borderColor: Color = .gray,
                          backgroundColor: Color = .blue, padding: CGFloat = 4) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: radius).stroke(borderColor, lineWidth: lineWidth)
            )
            .padding(padding)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: radius))
    }
    
    //MARK: - SCROLL VIEW Shading (above and below)
    func setScrollBorderShading() -> some View {
        self
            .mask(
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .top,
                                   endPoint: .bottom
                    )
                    .frame(height: 14)
                    Rectangle().fill(Color.black)
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                                   startPoint: .top,
                                   endPoint: .bottom
                    )
                    .frame(height: 20)
                }
            )
    }
}


@available(iOS 15.0, *)
extension View {
    //MARK: - SET COLOR for percentage change
    func setColor(_ value: String, gainColor: Color, lossColor: Color) -> Color {
        if value.contains("-") {
            return lossColor
        } else {
            return gainColor
        }
    }
    
    //MARK: - CREATE Image for Symbol (url || symbol || name prefixed)
    func AssetImageHandler(assetImageUrl: URL?, asset: UserEquity, size: CGFloat = 40, color: Color, fontColor: Color) -> some View {
        let symbol = asset.symbol?.lowercased()
        return Group {
            if symbol != "voc" {
                if let url = assetImageUrl {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .background(color)
                        .clipShape(Circle())
                } else {
                    if asset.type == .cash {
                        Text("$")
                            .font(.caption)
                            .imageBubble(size: size, color: color, fontColor: fontColor)
                    } else if let image = asset.symbol, image != "" {
                        Text(image.prefix(4))
                            .font(.caption2)
                            .imageBubble(size: size, color: color, fontColor: fontColor)
                    } else {
                        Text("")
                            .font(.caption2)
                            .imageBubble(size: size, color: color, fontColor: fontColor)
                    }
                }
            } else {
                // HANDLER for images with weird bugs (returned from 12data not working)
                Text(asset.symbol?.prefix(4) ?? "")
                    .font(.caption2)
                    .imageBubble(size: size, color: color, fontColor: fontColor)
            }
        }
    }
    

}


fileprivate extension Text {
     func imageBubble(size: CGFloat = 40, color: Color, fontColor: Color) -> some View {
        self
            .fontWeight(.semibold)
            .frame(width: size, height: size)
            .background(color)
            .foregroundStyle(fontColor)
            .clipShape(Circle())
    }
}



