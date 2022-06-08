//
//  TaskNavigation.swift
//  TaskBase
//
//  Created by Jeytery on 06.06.2022.
//

import Foundation
import UIKit

class TaskNavigation: UINavigationController {
    
    private let tasksVC = TasksViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setViewControllers([tasksVC], animated: false)
        tasksVC.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension TaskNavigation: TasksViewControllerDelegate {
    func tasksViewController(
        _ viewController: TasksViewController,
        didChoose task: Task
    ) {
        let vc = TaskViewController(task: task)
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.prefersLargeTitles = true
        present(
            nvc,
            animated: true,
            completion: nil
        )
    }
}
