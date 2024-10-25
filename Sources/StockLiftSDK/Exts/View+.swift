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
    
    @available(iOS 15.0, *)
    func glow() -> some View {
        self
            .foregroundColor(Color(hue: 0.5, saturation: 0.5, brightness: 1))
            .background {
                self
                    .foregroundColor(Color(hue: 207/360, saturation: 0.7, brightness: 0.94))
                    .blur(radius: 4)
            }
            .background {
                self
                    .foregroundColor(Color(hue: 214/360, saturation: 0.8, brightness: 1))
                    .blur(radius: 2)
            }
        //            .background {
        //                self
        //                    .foregroundColor(Color(hue: 214/360, saturation: 0.8, brightness: 0.94))
        //                    .blur(radius: 12)
        //            }
    }
    
    func makeCardLayer(width: CGFloat = UIScreen.main.bounds.width / 1.05,
                       color: Color = .gray.opacity(0.3),
                       radius: CGFloat = 14,
                       shadowRadius: CGFloat = 8) -> some View {
        self
            .frame(maxWidth: width)
            .background(color)
            .cornerRadius(radius)
            .shadow(radius: shadowRadius)
    }
    
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
    
    /// SCROLL VIEW Shading
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


@available(iOS 13.0, *)
public extension View {
    
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
    
    func headerFont(_ color: Color = .blue) -> some View {
        self
            .appFontMedium(size: 10, color: color)
    }
    
    func bodyFont(_ color: Color = .white) -> some View {
        self
            .appFontRegular(size: 10, color: color)
    }
}

@available(iOS 13.0, *)
public extension View {
    var rect: CGRect {
        UIScreen.main.bounds
    }
}

@available(iOS 13.0, *)
public extension View {
    // DIVIDER
    var SLDivider: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color.gray.opacity(0.3))
    }
}

@available(iOS 15.0, *)
public extension View {
    // SET COLOR for percentage change
    func setColor(_ value: String, upColor: Color = .green) -> Color {
        if value.contains("-") {
            return .red
        } else {
            return upColor
        }
    }
    
    // CREATE Image for Symbol (url or symbol or name prefixed)
    func AssetImageHandler(assetImageUrl: URL?, asset: UserEquity) -> some View {
        let symbol = asset.symbol?.lowercased()
        return Group {
            if symbol != "voc" {
                if let url = assetImageUrl {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding(.trailing, 8)
                } else {
                    if asset.type == .cash {
                        Text("$")
                            .appFontRegular()
                            .shadow(radius: 2)
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .padding(.trailing, 8)
                    } else if let image = asset.symbol, image != "" {
                        Text(image.prefix(4))
                            .appFontRegular(size: 12)
                            .shadow(radius: 2)
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .padding(.trailing, 8)
                    } else {
                        Text("")
                            .appFontRegular()
                            .shadow(radius: 2)
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .padding(.trailing, 8)
                    }
                }
            } else {
                // HANDLER for images with weird bugs (returned from 12data not working)
                Text(asset.symbol?.prefix(4) ?? "")
                    .appFontRegular(size: 12)
                    .shadow(radius: 2)
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
            }
        }
    }
}
