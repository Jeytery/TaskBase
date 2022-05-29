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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        tabBarItem = .init(title: nil, image: UIImage(systemName: "circle.grid.2x2.fill"), tag: 0)
        title = "Title"
        configureTableView()
//
//        let tabButton = UIBarButtonItem(
//            image: UIImage(systemName: "plus"),
//            style: .plain,
//            target: self,
//            action: #selector(tabButtonDidTap)
//        )
//        navigationItem.rightBarButtonItem = tabButton
        
        configureRightNavigationButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func tabButtonDidTap() {
        self.present(TabNavigation(rootViewController: TaskViewController()), animated: true, completion: nil)
    }
}

private extension TasksViewController {
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}

extension TasksViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        self.present(
            UINavigationController(rootViewController: TaskViewController()),
            animated: true,
            completion: nil
        )
    }
}
