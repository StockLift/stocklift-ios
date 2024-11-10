//
//  NetworkService+Plaid.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/10/24.
//

import Foundation

@available(iOS 13.0, *)
extension NetworkService {
    /// GET LINK TOKEN
    func getPlaidLinkToken(_ session: URLSession = .shared, complete: @escaping (Result<PlaidTokenResponse, SLError>) -> Void) {
        guard let companyName = StockLiftSDK.companyName else { fatalError(SLError.errorMessage(.companyNameNotSet))}
        session.request(.plaidLinkToken(companyName: companyName), method: .get, body: nil) { data, response, error in
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
    
    /// EXCHANGE TOKEN
    func exchangePlaidToken(request: PlaidExchangeRequest, _ session: URLSession = .shared, complete: @escaping (Result<(), SLError>) -> Void) {
        print(request)
        session.request(.plaidLinkToken(), method: .post, body: request.encode()) { data, response, error in
            if let _ = error {
                complete(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
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
//                let res = try decoder.decode(PlaidTokenResponse.self, from: data)
//                complete(.success(res))
//                return
//            } catch {
//                print(error)
//                complete(.failure(.invalidData))
//            }
        }
    }
}
