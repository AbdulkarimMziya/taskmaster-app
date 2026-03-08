//
//  NetworkHelper.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-07.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private let session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    
    func performTask(with urlRequest: URLRequest) async throws -> Data {
        let(data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}
