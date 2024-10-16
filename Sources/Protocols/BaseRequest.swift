//
//  BaseRequest.swift
//
//
//  Created by Christopher Hicks on 12/28/23.
//

import Foundation

public protocol BaseRequest: Codable { }

public extension BaseRequest {
    @discardableResult
    func encodeWithSnakeCasing() -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        if let encoded = try? encoder.encode(self) {
            return encoded
        } else {
            fatalError("Could not encode data \(self)")
        }
    }
    
    @discardableResult
    func encode() -> Data {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            return encoded
        } else {
            fatalError("Could not encode data \(self)")
        }
    }
}
