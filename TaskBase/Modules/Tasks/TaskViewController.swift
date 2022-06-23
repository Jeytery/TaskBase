//
//  TaskViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit
import SPDiffable

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
        configureTabButtons()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension TaskViewController {
    func configureTabButtons() {
        let plusImage = UIImage(systemName: "plus")!
        let plusButton = UIBarButtonItem(
            image: plusImage,
            style: .plain,
            target: self,
            action: #selector(didTapEditButton)
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapSearchButton)
        )
        navigationItem.rightBarButtonItems = [doneButton, plusButton]
    }
    
    @objc func didTapEditButton() {}
    
    @objc func didTapSearchButton() {}
    
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
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle != .delete { return }
        self.task.removeComponent(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
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
        return 60
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let component = task.components[indexPath.row]
        let vc = component.viewController
        
        navigationController?.pushViewController(vc, animated: true)
        
        if let data = component.input {
            vc.configure(data: data)
        }
    }
}


class __TaskViewController: SPDiffableTableController {
    
    weak var delegate: TaskViewControllerDelegate?
    
    private var task: Task
    
    private let bottomButtom = UIButton()

    init(task: Task? = nil) {
        self.task = task ?? .empty
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureLeftNavigationButton()
        configureTabButtons()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension __TaskViewController {
    var content: [SPDiffableSection] {
        let rows1: [SPDiffableTableRow] = [
            .init(text: "1")
        ]
        
        return [
            .init(
                id: "1",
                header: nil,
                footer: nil,
                items: rows1
            )
        ]
    }
}

private extension __TaskViewController {
    func configureTabButtons() {
        let plusImage = UIImage(systemName: "plus")!
        let plusButton = UIBarButtonItem(
            image: plusImage,
            style: .plain,
            target: self,
            action: #selector(didTapEditButton)
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapSearchButton)
        )
        navigationItem.rightBarButtonItems = [doneButton, plusButton]
    }
    
    @objc func didTapEditButton() {}
    
    @objc func didTapSearchButton() {}
    
    @objc func bottomButtonDidTap() {}
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Task"
    }
}

extension __TaskViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let componentsViewController = ComponentsViewController()
        let nc = UINavigationController(rootViewController: componentsViewController)
        present(nc, animated: true, completion: nil)
    }
}

extension __TaskViewController: LeftNavigationButtonable {
    func leftNavigationButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func leftNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .close
    }
}
