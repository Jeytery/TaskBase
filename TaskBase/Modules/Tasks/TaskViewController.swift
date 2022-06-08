//
//  TaskViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit

protocol TaskViewControllerDelegate: AnyObject {
    func taskViewController(_ viewController: UIViewController, didReturn task: Task)
}

class TaskViewController: UIViewController {
    
    weak var delegate: TaskViewControllerDelegate?
    
    private var task: Task
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let bottomButtom = UIButton()

    init(task: Task? = nil) {
        self.task = task ?? .empty
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureTableView()
      
        configureLeftNavigationButton()
        configureRightNavigationButton()
        configureBottomButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension TaskViewController {
    func configureBottomButton() {
        view.addSubview(bottomButtom)
        bottomButtom.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(50)
        }
        bottomButtom.setTitle("add", for: .normal)
        bottomButtom.backgroundColor = .black
        bottomButtom.addTarget(self, action: #selector(bottomButtonDidTap), for: .touchUpInside)
    }
    
    @objc func bottomButtonDidTap() {}
    
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
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return task.components.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
        
        let component = task.components[indexPath.row]
        
        cell.baseView.configure(
            icon: component.information.icon,
            color: component.information.color,
            title: component.information.name
        )
        cell.baseView.showSubtitle(component.outputData)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 70
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let component = task.components[indexPath.row]
        let vc = component.viewController
        
        navigationController?.pushViewController(vc, animated: true)
        
        if let data = component.input {
            vc.configure(data: data)
        }
    }
}

extension TaskViewController: ComponentsViewContorllerDelegate {
//    func componenstViewController(_ viewController: ComponentsViewController, didChoose component: Component) {
//        //components.append(component)
//        tableView.reloadData()
//    }
}
