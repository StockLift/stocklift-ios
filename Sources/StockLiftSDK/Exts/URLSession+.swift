//
//  URLSession+.swift
//  Stocklift SDK
//
//  Created by Christopher Hicks on 10/30/24.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func request(_ endpoint: Endpoint, method: NetworkService.Methods, body: Data? = nil, the handler: @escaping Handler) -> URLSessionDataTask {
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
