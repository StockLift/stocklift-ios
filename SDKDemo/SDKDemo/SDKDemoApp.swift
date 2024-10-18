//
//  SDKDemoApp.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK


/// VIEW MODEL
fileprivate class ContentViewModel: ObservableObject {
    init() {
        let clientHasAccount = SLClient(uuid: "test-123", name: "John Doe", email: "test@test.com")
        StockLiftSDK.client = clientHasAccount
        
        //        let clientDoesNotHaveAccount = SLClient(uuid: "test-456", name: "John Doe", email: "test@test.com")
        //        StockLiftSDK.client = clientDoesNotHaveAccount
    }
}



@main
struct SDKDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var viewModel = ContentViewModel()
    @State private var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            //            SLSectorBreakdownChart()
            ContentView(isDarkMode: $isDarkMode)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
