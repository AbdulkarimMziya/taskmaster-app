//
//  TaskDetailViewController.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-10.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    weak var delegate: TaskDetailDelegate?
    
    enum Mode {
        case add
        case edit(TodoTask)
    }
        
    let mode: Mode
    
    // UI Components
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter task name..."
        tf.font = .systemFont(ofSize: 24, weight: .bold)
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Completed"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .systemGreen
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
        
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupUI()
        configureMode()
    }
    
    private func setupUI() {
        setupNavBarButtons()
        view.addSubview(titleTextField)
        view.addSubview(statusLabel)
        view.addSubview(statusSwitch)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo:titleTextField.bottomAnchor, constant: 30),
            statusLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            
            statusSwitch.centerYAnchor.constraint(equalTo:statusLabel.centerYAnchor),
            statusSwitch.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureMode() {
        switch mode {
        case .add:
            title = "New Task"
            statusSwitch.isOn = false
        case .edit(let task):
            title = "Edit Task"
            titleTextField.text = task.title
            statusSwitch.isOn = task.isCompleted
        }
    }
    
    private func setupNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc
    private func didTapCancel() {
        
        dismiss(animated: true)
    }
    
    @objc
    private func didTapDone() {
        guard let title = titleTextField.text, !title.isEmpty else {
            dismiss(animated: true)
            return
        }

        let isCompleted = statusSwitch.isOn

        Task {
            do {
                switch mode {
                case .add:
                    let newTask = TodoTask(id: nil, title: title, isCompleted: isCompleted)
                    _ = try await TaskAPIService.createTask(newTask)

                case .edit(let existingTask):
                    let updatedTask = TodoTask(id: existingTask.id, title: title, isCompleted: isCompleted)
                    guard let id = existingTask.id else { return }
                    _ = try await TaskAPIService.updateTask(id: id, task: updatedTask)
                }

                await MainActor.run {
                    delegate?.didSaveTask()
                    dismiss(animated: true)
                }
            } catch {
                print(error)
            }
        }
    }
}

