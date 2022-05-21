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
    
    private let listView = ListView(style: .insetGrouped)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        title = "Task"
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        let nameView = IconInfoView(icon: UIImage(systemName: "highlighter")!, color: .systemRed, title: "Information")
        listView.addView(nameView)
        
        nameView.showSubtitle("Clean room, Get the fuck up and clean room")
        nameView.lock()
        
        let repeaterView = IconInfoView(
            icon: UIImage(systemName: "repeat")!,
            color: .systemBlue,
            title: "Repeater"
        )
        
        repeaterView.showSubtitle("12:00, Each 3 days")
        
        listView.addView(repeaterView)
        
        configureLeftNavigationButton()
        configureRightNavigationButton()
        
        listView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TaskViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let nc = UINavigationController(rootViewController: ComponentsViewController())
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

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
