//
//  ContentView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 9/24/24.
//

import SwiftUI
import StockLiftSDK

struct ContentView: View {
    @Binding var isDarkMode: Bool
    @State private var viewState: ViewState = .charts
    private var toggleTitle: String { isDarkMode ? "Light Mode" : "Dark Mode" }
    
    // TESTING View
    let testingView: [SLChartType]  = SLChartType.allCases
    
    private enum ViewState {
        case login, charts
        var title: String {
            switch self {
            case .login:
                return "Login"
            case .charts:
                return "Charts"
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(viewState.title)
                .font(.title)
                .onTapGesture { toggleView() }
            switch viewState {
            case .login:
                DemoLoginView(login: login)
            case .charts:
                Toggle(toggleTitle, isOn: $isDarkMode)
                    .padding(.horizontal)
                    .tint(.gray)
                NavigationStack {
                    ScrollView {
                        DemoAllChartsView(testingType: testingView)
                    }
                    .navigationTitle("Select a Chart Type")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    // LOGIN - (create a new test client from uuid)
    private func login(_ id: String) {
        let client: SLClient = .init(uuid: id, name: "TEST-\(id)", email: "test-\(id)@test.com")
        StockLiftSDK.client = client
        toggleView()
    }
    
    // TOGGLE View
    private func toggleView() {
        switch viewState {
        case .login:
            viewState = .charts
        case .charts:
            viewState = .login
        }
    }
}





