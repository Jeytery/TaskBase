//
//  TaskViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit

class TaskViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonDidTap)
        )
        navigationItem.rightBarButtonItem = addButton
        
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonDidTap)
        )
        navigationItem.leftBarButtonItem = closeButton
        
        view.backgroundColor = .systemBackground
        title = "Task"
    }
    
    @objc func addButtonDidTap() {
        navigationController?.pushViewController(
            ComponentsViewController(),
            animated: true
        )
    }
    
    @objc func closeButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
