//
//  ComponentViewControllerable.swift
//  TaskBase
//
//  Created by Jeytery on 29.05.2022.
//

import UIKit

protocol ComponentViewControllerable: UIViewController {
    var delegate: ComponentViewControllerDelegate? { get set }
}

protocol ComponentViewControllerDelegate: AnyObject {
    func viewController(_ viewController: UIViewController, didReturn component: Component)
}
