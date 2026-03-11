//
//  tableDataSourceExtension.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-08.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todo = todoTasks[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = todo.title
        content.secondaryText = todo.isCompleted ? "Completed" : "Pending"
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
