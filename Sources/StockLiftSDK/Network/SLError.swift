//
//  SLError.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//
//

import Foundation

public enum SLError: String, Error {
    case logOut = "Oops you need to sign out and back in to reset your access token."
    case invalidUserName = "Almost, but this username already exist, please try again."
    case unableToComplete = "We were un-able to complete your request. Please check your internet connection."
    case invalidResponse = "Well thats weird...invalid response from server, please try again."
    case invalidData = "The data received from the server was invalid .... were working on it."
    case invalidURL = "Sorry the request had an issue getting data back, try again shortly."
    case resetLinkedAccount = "Your credentials have changed with your account, we need you to reconnect your Institution."
    case searchQueryIssue = "Oops... maybe try a different spelling"
    case invalidCredentials = "Sorry your credentials are invalid. Please email reactivate@stocklift.co for further help."
    case incorrectPurchaseAmount = "This purchase amount exceeds your cash availability. Please select a new amount."
    case contestOver = "Check back shortly, you can begin adding stocks for next week’s round after 5:15pm EST."
    case duplicateAccount = "Oops it looks like you have already linked one of these accounts, try again with a new account."
    case countryNotSupported = "Apologies, but at this time we do not support this country. We are working to get there though!"
    case canNotClaim = "You can not claim this."
    
    static func errorMessage(_ message: String) -> String {
        return """
    \n\n*** ⛔️  StockLift SDK ERROR  ⛔️ ***\n\n\(message)\n\n⛔️ https://sdk-stocklift.co/docs/ ⛔️\n\n
    """
    }
}
