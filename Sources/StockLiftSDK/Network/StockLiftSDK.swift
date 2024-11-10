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
     --- Set your Company Name here ---
     */
    static public var companyName: String? = nil
    
    /**
     --- Set your Clients Details here ---
     */
    static public var client: SLClient? = nil
    
    
    public init() {
        guard let token = Self.accessToken, !token.isEmpty else {
            fatalError(SLError.errorMessage(.accessTokenNotSet))
        }
        guard let companyName = Self.companyName, !companyName.isEmpty else {
            fatalError(SLError.errorMessage(.companyNameNotSet))
        }
    }
}
