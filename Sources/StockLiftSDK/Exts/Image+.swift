//
//  Image+.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 11/4/24.
//

import SwiftUI

extension Image {
    func imageHandler() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}
