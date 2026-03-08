//
//  ViewController.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-07.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    var tasks = [TodoTask]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        loadData()
        
    }
   
    func loadData() {
            Task {
                do {
                    // 2. Assign the result to your local array
                    self.tasks = try await TaskAPIService.fetchAllTasks()
                    
                    // 3. Test by printing the count and dumping the first item
                    print("Successfully fetched \(self.tasks.count) tasks.")
                    if let firstTask = self.tasks.first {
                        dump(firstTask)
                    }
                } catch {
                    print("Network Error: \(error)")
                }
            }
        }

}

