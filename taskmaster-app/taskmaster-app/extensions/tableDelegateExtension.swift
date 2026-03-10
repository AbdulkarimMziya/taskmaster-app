//
//  tableDelegateExtension.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-09.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 1. Define the action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // TODO: Handle deletion request
            print("Delete tapped")
            
            // TODO: Update todoTasks
            // Update data source (e.g., array.remove(at: indexPath.row))
            // tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true) // Pass true if action was performed
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
