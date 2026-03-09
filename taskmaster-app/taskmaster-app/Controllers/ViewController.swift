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

    var todoTasks = [TodoTask]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup Add Button
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem = addButton
        
        // Setup Table
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        loadData()
    }

    @objc
    private func didTapAdd() {
        print("Plus button tapped! Time to show a UIAlertController to create a task.")
    }

    func loadData() {
            Task {
                do {
                    // 2. Assign the result to your local array
                    self.todoTasks = try await TaskAPIService.fetchAllTasks()
                    
                    // 3. Test by printing the count and dumping the first item
                    print("Successfully fetched \(self.todoTasks.count) tasks.")
                } catch {
                    print("Network Error: \(error)")
                }
            }
        }

}

