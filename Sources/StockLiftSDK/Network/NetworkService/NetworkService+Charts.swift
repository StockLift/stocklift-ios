//
//  NetworkService+Charts.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 9/24/24.
//

import Foundation

//MARK:  -------------------- COMING SOON ------------------------

@available(iOS 13.0, *)
extension NetworkService {
    //MARK: ***************************************************************** GROWTH CHART **************************************************
    /// GROWTH CHART - async/await
    func getGrowthChart(userUuid: String) async throws -> [GrowthTimeline] {
        return try await withCheckedThrowingContinuation { continuation in
            getGrowthChart(userUuid: userUuid, with: .shared) { result in
                switch result {
                case .success(let res):
                    continuation.resume(returning: res.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// GROWTH Chart
    func getGrowthChart(userUuid: String, with session: URLSession = .shared, complete: @escaping (Result<GrowthChartResponse, SLError>) -> Void) {
//        session.request(.getPortfolio, method: .get, body: nil) { data, response, error in
//            if let _ = error {
//                complete(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                complete(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                complete(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let res = try decoder.decode(GrowthChartResponse.self, from: data)
//                complete(.success(res))
//                return
//            } catch {
//                print(error)
//                complete(.failure(.invalidData))
//            }
//        }
    }
    
    //MARK: ***************************************************************** SECTOR CHART **************************************************
    /// SECTOR Chart
    @MainActor func getSectorChart(userUuid: String, with session: URLSession = .shared, complete: @escaping @Sendable (Result<(), SLError>) -> Void) {
//        session.request(.getPortfolio, method: .get, body: nil) { data, response, error in
//            if let _ = error {
//                complete(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                complete(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let _ = data else {
//                complete(.failure(.invalidData))
//                return
//            }
//            
//            complete(.success(()))
//            
//            //            do {
//            //                let decoder = JSONDecoder()
//            //                let res = try decoder.decode(PortfolioResponse.self, from: data)
//            //                complete(.success(res))
//            //                return
//            //            } catch {
//            //                Self.logger.error("\(error)")
//            //                complete(.failure(.invalidData))
//            //            }
//        }
    }
    
    //MARK: ***************************************************************** PERFORMANCE CHART **************************************************
    /// PERFORMANCE Chart
    @MainActor func getPerformanceChart(userUuid: String, with session: URLSession = .shared, complete: @escaping @Sendable (Result<(), SLError>) -> Void) {
//        session.request(.getPortfolio, method: .get, body: nil) { data, response, error in
//            if let _ = error {
//                complete(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                complete(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let _ = data else {
//                complete(.failure(.invalidData))
//                return
//            }
//            
//            complete(.success(()))
//            
//            //            do {
//            //                let decoder = JSONDecoder()
//            //                let res = try decoder.decode(PortfolioResponse.self, from: data)
//            //                complete(.success(res))
//            //                return
//            //            } catch {
//            //                Self.logger.error("\(error)")
//            //                complete(.failure(.invalidData))
//            //            }
//        }
    }
}
