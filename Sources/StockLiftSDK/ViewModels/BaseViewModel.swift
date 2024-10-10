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
    
    init() {
    }


}
