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
        let client = SLClient(
            uuid: "test-123",
            name: "John Doe",
            email: "test@test.com",
            age: 26,
            country: "US",
            state: "New York"
        )
        StockLiftSDK.client = client
    }
}


@main
struct SDKDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var viewModel = ContentViewModel()
    @State private var isDarkMode: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView(isDarkMode: $isDarkMode)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
