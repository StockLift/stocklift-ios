//
//  NetworkService.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//
//

import UIKit

@available(iOS 13.0, *)
public final class NetworkService: StockLiftSDK {
    
    public static let shared = NetworkService()
    private let defaults = UserDefaults.standard
    
    var deviceId: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "NO_DEVICE_ID"
    }
    
    /// HEADERS
    var baseHeaders: [String : String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(Self.accessToken!)",
            "x-client-id": "\(Self.client?.uuid)",
            "x-device-id": "\(deviceId)",
        ]
    }
    
    /// HTTP Methods
    public enum Methods: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}


