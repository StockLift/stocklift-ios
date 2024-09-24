//
//  BaseViewModel.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI

@available(iOS 13.0, *)
open class BaseViewModel: ObservableObject {
    
    @Published public var showAlert: Bool = false
    @Published public var alertTitle: String = "Oops"
    @Published public var alertMessage: String = "Well thats embarasing...."
    
    
    /// ERROR ALERT HANDLER
    public func handleAlert(err: SLError, codeSheet: String, complete: @escaping () -> Void) {
        //TODO: - setup
//        DispatchQueue.main.async {
//            switch err {
//            case .logOut:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .invalidUserName:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .unableToComplete:
//                print("ERROR:::>>>>---- \(err) \(codeSheet)")
//            case .invalidResponse:
//                print("ERROR:::>>>>---- \(err) \(codeSheet)")
//            case .invalidData:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .invalidURL:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .resetLinkedAccount:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .searchQueryIssue:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .invalidCredentials:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .incorrectPurchaseAmount:
//                self.alertTitle = "Slow down buddy!"
//                self.alertMessage = err.rawValue
//                self.showAlert = true
//            case .contestOver:
//                self.alertTitle = "Glad to see you’re ambitious!"
//                self.alertMessage = err.rawValue
//                self.showAlert = true
//            case .duplicateAccount:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .countryNotSupported:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            case .canNotClaim:
//                self.alertTitle = "Oops!"
//                self.alertMessage = err.rawValue + "\n\(codeSheet)"
//                self.showAlert = true
//                handle(err, codeSheet: codeSheet)
//            }
//            complete()
//            print("ERROR:::>>>>---- \(err) \(codeSheet)")
//        }
//        
//        func handle(_ err: SLError, codeSheet: String) {
//#if RELEASE
//            if err != .invalidCredentials &&
//                err != .incorrectPurchaseAmount {
//                self.sendSlackMessage(codeSheet: codeSheet,
//                                      message: "\(err.rawValue)",
//                                      data: "EMAIL: \(self.currentUser?.email ?? "") - UUID: \(self.currentUser?.uid ?? "")")
//            }
//#endif
//        }
    }
}
