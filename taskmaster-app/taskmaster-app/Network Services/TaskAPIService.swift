//
//  TaskAPIService.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-08.
//

import Foundation

class TaskAPIService {
    
    // Get all Tasks
    static func fetchAllTasks() async throws -> [Task] {
        // 1. Create url component
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "localhost:4000"
        urlComponent.path = "/api/tasks"
        
        // 2. Validate url
        guard let url = urlComponent.url else {
            throw NetworkError.invalidURL(urlComponent.string ?? "")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // 3. Perform fetch request
        let data = try await NetworkHelper.shared.performTask(with: urlRequest)
        
        // 4. Decode the data
        var tasks = [Task]()
        do {
            let decoder = JSONDecoder()
            tasks = try decoder.decode([Task].self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
 
        return tasks
    }
}
