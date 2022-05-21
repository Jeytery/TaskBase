//
//  ComponentsViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

protocol ComponentsViewContorllerDelegate: AnyObject {
    func componenstViewController(
        _ viewController: ComponentsViewController,
        didChoose component: Int
    )
}

class ComponentsViewController: UIViewController {
    
    weak var delegate: ComponentsViewContorllerDelegate?
    
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
            IconInfoView(
                icon: UIImage(systemName: "repeat")!,
                color: .systemBlue,
                title: "Repeater"
            ),
            IconInfoView(
                icon: UIImage(systemName: "person.fill")!,
                color: .systemTeal,
                title: "Binder"
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
        
        listView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        listView.allowsSelection = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ComponentsViewController: ListViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(RepeaterViewController(), animated: true)
    }
    
    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? {
        return " "
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
