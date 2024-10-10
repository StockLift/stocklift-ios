//
//  StockLiftSDK.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

/// --------   https://sdk-stocklift.co/docs/
public class StockLiftSDK {
    /**
     --- Set your API Access Token here ---
     */
    static public var accessToken: String? = nil
    
    /**
     --- Set your Clients Details here ---
     */
    static public var client: SLClient? = nil
    
    
    public init() {
        guard let token = Self.accessToken, !token.isEmpty else {
            fatalError("""
\n\n*** StockLift SDK ERROR ***\nYou must set your API Key in the StockLiftSDK.accessToken variable.\n\nhttps://sdk-stocklift.co/docs/\n\n
""")
        }
    }
}
