//
//  Helper.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/15/24.
//

import SwiftUI
import StockLiftSDK

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
    
    static func saveSLClientToUserDefaults(_ client: SLClient) {
        let defaults = UserDefaults.standard
        do {
            try defaults.setObject(client, forKey: "sdk_client")
        } catch {
            print(error)
        }
    }
    
    static func getSLClientFromUserDefaults() -> SLClient? {
        let defaults = UserDefaults.standard
        
        do {
            let client =  try defaults.getObject(forKey: "sdk_client", castTo: SLClient.self)
            return client
        } catch {
            print(error)
        }

        return nil
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




extension UserDefaults {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object : Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object : Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}


enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}


