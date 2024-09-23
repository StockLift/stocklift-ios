//
//  View+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI

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
}
