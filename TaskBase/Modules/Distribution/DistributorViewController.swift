//
//  DistributorViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

class DistributorViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        tabBarItem = .init(title: nil, image: UIImage(systemName: "bolt.fill"), tag: 0)
        title = "To Do"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
