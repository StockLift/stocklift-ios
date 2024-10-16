//
//  UserDefaults+.swift
//  Stocklift
//
//  Created by Christopher Hicks on 2/27/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI

public extension UserDefaults {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object : Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object : Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}


public enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    public var errorDescription: String? {
        rawValue
    }
}



public extension UserDefaults {
    func saveImage(_ image: UIImage, key: String) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    func loadImage(_ key: String) -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        return image
    }
}
