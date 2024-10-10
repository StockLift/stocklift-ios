//
//  NetworkService+Plaid.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

@available(iOS 13.0, *)
public extension NetworkService {
    // GET LINK TOKEN
    func getPlaidLinkToken(_ session: URLSession = .shared, complete: @escaping (Result<PlaidTokenResponse, SLError>) -> Void) {
        session.request(.plaidLinkToken, method: .get, body: nil) { data, response, error in
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
                let res = try decoder.decode(PlaidTokenResponse.self, from: data)
                complete(.success(res))
                return
            } catch {
                print(error)
                complete(.failure(.invalidData))
            }
        }
    }
}
