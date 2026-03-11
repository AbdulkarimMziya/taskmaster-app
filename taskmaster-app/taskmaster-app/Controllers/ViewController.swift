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
        setupUI()
        loadData()
    }

    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(didTapAdd)
        )

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc
    private func didTapAdd() {
        let detailVC = TaskDetailViewController(mode: .add)
        detailVC.delegate = self
        present(UINavigationController(rootViewController: detailVC), animated: true)
    }

    func loadData() {
        Task {
            do {
                let tasks = try await TaskAPIService.fetchAllTasks()
                await MainActor.run {
                    self.todoTasks = tasks
                }
            } catch {
                print("Network Error: \(error)")
            }
        }
    }
}
