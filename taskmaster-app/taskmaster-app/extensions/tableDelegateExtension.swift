//
//  tableDelegateExtension.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-09.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = todoTasks[indexPath.row]
        let editVC = TaskDetailViewController(mode: .edit(task))
        editVC.delegate = self
        let navController = UINavigationController(rootViewController: editVC)
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 1. Define the action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            guard let id = self.todoTasks[indexPath.row].id else {
                completionHandler(false)
                return
            }
            
            // perform asyn action to remove TodoTask
            Task {
                do {
                    let data = try await TaskAPIService.deleteTask(id: id)
                    
                    await MainActor.run {
                        self.todoTasks.remove(at: indexPath.row)
                        completionHandler(true)
                        dump(data)
                    }
                } catch {
                    completionHandler(false)
                    print(error)
                }
                
            }
        }
        
        // Customize action
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        // 2. Return the configuration with actions
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

}
