//
//  NetworkError.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-08.
//

import Foundation

enum NetworkError: Error {
    case noResponse
    case badStatusCode(Int)
    case invalidURL(String)
    case decodeError(Error)
}
