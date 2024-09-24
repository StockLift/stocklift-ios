//
//  StockLiftSDK.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public class StockLiftSDK {
    /**
         **********   Set your API Token here ************
     */
    static let accessToken: String? = "YOUR_ACCESS_TOKEN"
    
    public init() {
        guard StockLiftSDK.accessToken != nil else {
            let error = NSError(domain: "StockLiftSDK", code: 1, userInfo: nil)
           fatalError(error.localizedDescription)
        }
        
        guard let token = StockLiftSDK.accessToken, !token.isEmpty else {
            let error = NSError(domain: "StockLiftSDK", code: 2, userInfo: nil)
            fatalError(error.localizedDescription)
        }
    }
}
