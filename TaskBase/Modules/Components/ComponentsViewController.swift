//
//  ComponentsViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

class ComponentsViewController: UIViewController {
    
    private var listView: ListView!
    
    private let titles: [String] = [
        "Task will show repeatetlly after time interval which you can setup",
        "Add names of your friends and this option will bind it step by step whenever this task will show"
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        
        title = "Components"
        
        let views = [
            ComponentView(
                color: .systemGreen,
                icon: UIImage(systemName: "repeat")!,
                title: titles[0],
                componentName: "Repeater"
                
            ),
            ComponentView(
                color: .systemBlue,
                icon: UIImage(systemName: "person.fill.checkmark")!,
                title: titles[1],
                componentName: "Binder"
            )
        ]
        
        listView = ListView(views: views, style: .insetGrouped)

        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        listView.listDataSource = self
        listView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ComponentsViewController: ListViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 + titles[indexPath.section].height(
            withConstrainedWidth: tableView.frame.width - 60,
            font: .systemFont(ofSize: 22, weight: .semibold)
        )
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font], context: nil
        )
        return ceil(boundingBox.width)
    }
}
