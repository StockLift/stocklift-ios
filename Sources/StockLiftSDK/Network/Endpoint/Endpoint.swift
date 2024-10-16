//
//  Endpoint.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//
//

import Foundation

//TODO: - finish setup
fileprivate enum AppEnv {
    case prod, dev
    
    var name: String {
        switch self {
        case .prod:
            return "Production"
        case .dev:
            return "Development"
        }
    }
}

public struct Endpoint {
    public var path: String
    public var queryItems: [URLQueryItem]
    
    public init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
    
    private var appEnv: AppEnv {
        self.getEnvironment()
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        switch appEnv {
        case .prod:
            components.scheme = "https"
            components.host = "sdk-stocklift-9a545489079b.herokuapp.com"
            components.port = nil
            
        case .dev:
            
            components.scheme = "https"
            components.host = "sdk-dev-79b2be5acd71.herokuapp.com"
            components.port = nil
            
            
//            components.scheme = "http"
//            components.host = "0.0.0.0"
//            components.port = 8443
    
        }
        
        components.path = "/sdk/" + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("🌎 Invalid URL Components: \(components)")
        }

        print("🐞URL DEBUG: \(url)")
        print("🌎 -> App is running in: \(appEnv.name)")
 
        return url
        
    }
    
    private func getEnvironment() -> AppEnv {
        #if RELEASE
            return .prod
        #elseif DEBUG
            return .dev
        #else
            return .prod
        #endif
    }
}

