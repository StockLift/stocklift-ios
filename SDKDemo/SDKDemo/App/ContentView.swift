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
    
    // Current Testing View (set to empty to show default demo layout)
    private let testingView: [SLChartType] = []
    
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
        NavigationStack {
            Text(viewState.title)
                .font(.title)
                .onTapGesture { withAnimation(.easeInOut) {toggleView()} }
            switch viewState {
            case .login:
                    DemoLoginView(login: login)
            case .charts:
                VStack {
                    // Example Vertical Views
                    HStack {
                        NavigationLink { Example1View()
                        } label: { Text("Vertical 1").font(.callout).tint(Color.secondary).underline() }
                        Spacer()
                        NavigationLink { Example2View()
                        } label: { Text("Vertical 2").font(.callout).tint(Color.secondary).underline() }
                    }
                    .padding(.horizontal)
                    
                    // LIGHT / DARK Toggle
                    Toggle(toggleTitle, isOn: $isDarkMode)
                        .padding(.horizontal)
                        .tint(.secondary)
              
                    // VIEW
                    ScrollView {
                        DemoAllChartsView(testingType: testingView)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
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





