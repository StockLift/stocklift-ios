//
//  AssetImageResponse.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/29/24.
//

import Foundation

public struct AssetImageResponse: Codable {
    public let url: String?
    
    public init(url: String?) {
        self.url = url
    }
}
