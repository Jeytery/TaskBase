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
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var components: [Component] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureTableView()
      
        configureLeftNavigationButton()
        configureRightNavigationButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension TaskViewController {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Task"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ViewableTableViewCell<IconInfoView>.self, forCellReuseIdentifier: "cell")
    }
}

extension TaskViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let componentsViewController = ComponentsViewController()
        componentsViewController.delegate = self
        let nc = UINavigationController(rootViewController: componentsViewController)
        present(nc, animated: true, completion: nil)
    }
}

extension TaskViewController: LeftNavigationButtonable {
    func leftNavigationButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func leftNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .close
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
        
        let component = components[indexPath.row]
        cell.baseView.configure(
            icon: component.information.icon,
            color: component.information.color,
            title: component.information.name
        )
        cell.baseView.showSubtitle(component.information.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension TaskViewController: ComponentsViewContorllerDelegate {
    func componenstViewController(_ viewController: ComponentsViewController, didChoose component: Component) {
        components.append(component)
        tableView.reloadData()
    }
}
