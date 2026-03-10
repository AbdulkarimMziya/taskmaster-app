//
//  TaskDetailViewController.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-10.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    enum Mode {
        case add
        case edit(TodoTask)
    }
        
    let mode: Mode
        
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray

        setupNavBarButtons()
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
        dismiss(animated: true)
    }
    

}
