//
//  TabViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

class TabNavigation: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
    }
}

class TabViewController: UITabBarController {
    
    private let tabControllers = [
        TaskNavigation(),
        TabNavigation(
            rootViewController: SettingsViewController()
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabControllers, animated: false)
    }
}


