//
//  DemoLoginView.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/21/24.
//

import SwiftUI

struct DemoLoginView: View {
    let login: (String) -> Void
    @State private var userUuid: String = ""
    var body: some View {
        TextField("User uuid", text: $userUuid)
            .keyboardType(.default)
            .autocapitalization(.none)
            .padding()
        Divider()
        Text("Submit")
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(Color.white)
            .background(Color.purple)
            .cornerRadius(10)
            .onTapGesture {
                login(userUuid)
            }
        Spacer()
    }
}
