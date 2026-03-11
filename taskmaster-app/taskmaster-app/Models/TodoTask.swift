//
//  Task.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-08.
//

import Foundation

struct TodoTask: Identifiable, Codable {
    let id: String?
    let title: String
    let isCompleted: Bool

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case isCompleted
    }
}

