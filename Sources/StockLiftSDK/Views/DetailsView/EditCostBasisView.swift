//
//  EditCostBasisView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/8/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI

//TODO: - config custom text field and button views 
@available(iOS 13.0, *)
struct EditCostBasisView: View {
    var updateCostBasisAction: (String, Float) -> Void
    @Binding var showUpdateCostBasis: (Bool, String)
    
    @State private var enteredCostBasis: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("x")
                    .appFontMedium()
                    .onTapGesture { showUpdateCostBasis.0.toggle() }
            }
            VStack(spacing: 4) {
                Text("Update Cost Basis")
                    .appFontMedium()
                Text("\(showUpdateCostBasis.1)")
                    .appFontMedium(size: 16)
            }
//            CustomTextField(text: $enteredCostBasis, placeholder: "", keyboardType: .numberPad)
//                .padding(.vertical)
            
            Text("Please wait 24hrs for all data to update")
                .appFontRegular(size: 10, color: .gray)
                .padding(.vertical, 8)
            
//            SLButton("Submit")
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    if let value = Float(enteredCostBasis) {
//                        updateCostBasisAction(showUpdateCostBasis.1, value)
//                        showUpdateCostBasis.0.toggle()
//                        FBAnalytics.shared.logEvent(name: .editCostBasis)
//                    }
//                }
        }
//        .setAnalyticsView("Edit Cost Basis View")
        .padding()
//        .makeCardLayer()
    }
}


