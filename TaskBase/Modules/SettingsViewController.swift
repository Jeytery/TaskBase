//
//  SettingsViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {
   
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        tabBarItem = .init(title: nil, image: UIImage(systemName: "gear"), tag: 0)
        title = "Settings"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

