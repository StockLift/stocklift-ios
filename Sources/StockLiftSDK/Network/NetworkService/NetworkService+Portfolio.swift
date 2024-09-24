//
//  NetworkService+Portfolio.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

@available(iOS 13.0, *)
public extension NetworkService {
    
    // GET PORTFOLIO Data
    @MainActor func getPortfolio(userUuid: String, with session: URLSession = .shared, complete: @escaping @Sendable (Result<(), SLError>) -> Void) {
        session.request(.getPortfolio, method: .get, body: nil) { data, response, error in
            if let _ = error {
                complete(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complete(.failure(.invalidResponse))
                return
            }
            
            guard let _ = data else {
                complete(.failure(.invalidData))
                return
            }
            
            complete(.success(()))
            
//            do {
//                let decoder = JSONDecoder()
//                let res = try decoder.decode(PortfolioResponse.self, from: data)
//                complete(.success(res))
//                return
//            } catch {
//                Self.logger.error("\(error)")
//                complete(.failure(.invalidData))
//            }
        }
    }
}

