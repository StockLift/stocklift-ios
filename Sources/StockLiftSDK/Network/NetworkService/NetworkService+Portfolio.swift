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
   func getPortfolio(clientId: String, with session: URLSession = .shared, complete: @escaping (Result<PortfolioResponse, SLError>) -> Void) {
        session.request(.getPortfolio(clientId), method: .get, body: nil) { data, response, error in
            if let _ = error {
                complete(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complete(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                complete(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let res = try decoder.decode(PortfolioResponse.self, from: data)
                complete(.success(res))
                return
            } catch {
                print(error)
                complete(.failure(.invalidData))
            }
        }
    }
}

