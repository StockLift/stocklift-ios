//
//  URLSession+.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/20/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
public extension URLSession {
//    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
//    @discardableResult
//    func request(_ endpoint: Endpoint, method: UserService.Methods, the handler: @escaping Handler) -> URLSessionDataTask {
//        var request = URLRequest(url: endpoint.url)
//        request.allHTTPHeaderFields = UserService.shared.baseHeaders
//        request.httpMethod = method.rawValue
//        let task = dataTask(with: request, completionHandler: handler)
//        task.resume()
//        return task
//    }
//    
//    // DEPRECATED
//    @discardableResult
//    func requestWithBody(_ endpoint: Endpoint, method: UserService.Methods, body: [String: Any], the handler: @escaping Handler) -> URLSessionDataTask {
//        var request = URLRequest(url: endpoint.url)
//        request.allHTTPHeaderFields = UserService.shared.baseHeaders
//        request.httpMethod = method.rawValue
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//        let task = dataTask(with: request, completionHandler: handler)
//        task.resume()
//        return task
//    }
//    
//    // DEPRECATED
//    @discardableResult
//    func requestWithData(_ endpoint: Endpoint, method: UserService.Methods, body: Data, the handler: @escaping Handler) -> URLSessionDataTask {
//        var request = URLRequest(url: endpoint.url)
//        request.allHTTPHeaderFields = UserService.shared.baseHeaders
//        request.httpMethod = method.rawValue
//        request.httpBody = body
//        let task = dataTask(with: request, completionHandler: handler)
//        task.resume()
//        return task
//    }
    
    @discardableResult
    func request(_ endpoint: Endpoint, method: NetworkService.Methods, body: Data?, the handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = NetworkService.shared.baseHeaders
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = body
        }
        let task = dataTask(with: request, completionHandler: handler)
        task.resume()
        return task
    }
}
