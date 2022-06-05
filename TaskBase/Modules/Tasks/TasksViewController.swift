//
//  TasksViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

class TasksViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    //private var tasks: [Task] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureTableView()
        configureRightNavigationButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension TasksViewController {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        tabBarItem = .init(title: nil, image: UIImage(systemName: "circle.grid.2x2.fill"), tag: 0)
        title = "Title"
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

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tasks.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
//        let task = tasks[indexPath.row]
//        let descDataComp = task.descriptionComponent
//        cell.baseView.configure(
//            icon: UIImage(systemName: "scribble.variable")!,
//            color: .systemBlue,
//            title: descDataComp.handler.outputData
//        )
        return UITableViewCell()
    }
}

extension TasksViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let taskVC = TaskViewController()
        taskVC.delegate = self
        self.present(
            UINavigationController(rootViewController: taskVC),
            animated: true,
            completion: nil
        )
    }
}

extension TasksViewController: TaskViewControllerDelegate {
//    func taskViewController(_ viewController: UIViewController, didCreate task: Task) {
//        viewController.dismiss(animated: true, completion: nil)
//        tasks.append(task)
//        tableView.reloadData()
//    }
}
