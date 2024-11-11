//
//  SLError.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//
//

import Foundation

enum SLError: String, Error {
    case unableToComplete = "We were un-able to complete your request. Please check your internet connection."
    case invalidResponse = "Well thats weird...invalid response from server, please try again."
    case invalidData = "The data received from the server was invalid .... were working on it."
    case invalidURL = "Sorry the request had an issue getting data back, try again shortly."
    case resetLinkedAccount = "Your credentials have changed with your account, we need you to reconnect your Institution."
    
    // SDK
    case clientDetailsNotSet = "Please set the client details before connecting accounts."
    case accessTokenNotSet = "You must set your API Key in the StockLiftSDK.accessToken variable."
    case companyNameNotSet = "You must set your Company Name in the StockLiftSDK.companyName variable."
    
    static func errorMessage(_ message: SLError = .clientDetailsNotSet) -> String {
        return """
    \n\n*** ⛔️  StockLift SDK ERROR  ⛔️ ***\n\n\(message)\n\n⛔️ https://sdk-stocklift.co/docs/ ⛔️\n\n
    """
    }
}
