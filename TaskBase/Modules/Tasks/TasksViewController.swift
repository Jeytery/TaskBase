//
//  TasksViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

protocol TasksViewControllerDelegate: AnyObject {
    func tasksViewController(_ viewController: TasksViewController, didChoose task: Task)
}

class TasksViewController: UIViewController {

    weak var delegate: TasksViewControllerDelegate?
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var tasks: [Task] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureTableView()
        configureRightNavigationButton()

        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func fetchData() {
        let tasksService = TasksService()
        self.tasks = tasksService.getTasks()
        tableView.reloadData()
    }
}

private extension TasksViewController {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        tabBarItem = .init(title: nil, image: UIImage(systemName: "circle.grid.2x2.fill"), tag: 0)
        title = "Tasks"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ViewableTableViewCell<IconInfoView>.self,
            forCellReuseIdentifier: "cell"
        )
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return tasks.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
        let task = tasks[indexPath.row]
        
        let descDataComp = task.descriptionComponent
        
        if let input = descDataComp.input {
            let input = DesriptionInput.unarchive(data: input)
            cell.baseView.configure(
                icon: UIImage(systemName: "scribble.variable")!,
                color: .systemBlue,
                title: input.name
            )
            cell.baseView.showSubtitle(input.description)
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let task = tasks[indexPath.row]
        delegate?.tasksViewController(self, didChoose: task)
    }
}

extension TasksViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let taskVC = TaskViewController()
        self.present(
            UINavigationController(rootViewController: taskVC),
            animated: true,
            completion: nil
        )
    }
}
