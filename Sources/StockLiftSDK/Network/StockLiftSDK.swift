//
//  StockLiftSDK.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

public class StockLiftSDK {
    /**
     --- Set your API Access Token here ---
     https://sdk-stocklift.co/docs/
     */
    static public var accessToken: String? = nil
    static public var userUuid: String? = nil
    
    public init() {
        guard let token = Self.accessToken, !token.isEmpty else {
            fatalError("You must set your API Key in the StockLiftSDK.accessToken variable. https://sdk-stocklift.co/docs/")
        }
    }
}
