//
//  TaskAPIService.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-08.
//

import Foundation

class TaskAPIService {

    enum HTTPMethod: String {
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case get = "GET"
    }

    private static func makeURL(path: String) throws -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 4000
        components.path = path
        guard let url = components.url else {
            throw NetworkError.invalidURL(components.string ?? path)
        }
        return url
    }

    static func fetchAllTasks() async throws -> [TodoTask] {
        let url = try makeURL(path: "/api/tasks")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        let data = try await NetworkHelper.shared.performTask(with: request)

        do {
            return try JSONDecoder().decode([TodoTask].self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
    }

    static func createTask(_ task: TodoTask) async throws -> TodoTask {
        return try await performTaskRequest(.post, path: "/api/task", body: task)
    }

    static func updateTask(id: String, task: TodoTask) async throws -> TodoTask {
        return try await performTaskRequest(.put, path: "/api/task/\(id)", body: task)
    }

    static func deleteTask(id: String) async throws -> TodoTask {
        return try await performTaskRequest(.delete, path: "/api/task/\(id)")
    }

    // MARK: - Private

    private static func performTaskRequest(
        _ method: HTTPMethod,
        path: String,
        body: TodoTask? = nil
    ) async throws -> TodoTask {
        let url = try makeURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw NetworkError.encodeError(error)
            }
        }

        let data = try await NetworkHelper.shared.performTask(with: request)

        do {
            return try JSONDecoder().decode(TodoTask.self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
    }
}
