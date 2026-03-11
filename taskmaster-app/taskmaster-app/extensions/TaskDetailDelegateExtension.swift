//
//  TaskDetailDelegateExtension.swift
//  taskmaster-app
//
//  Created by Abdulkarim Mziya on 2026-03-10.
//

import Foundation

extension ViewController: TaskDetailDelegate {
    func didSaveTask() {
        self.loadData()
    }
    
}
