//
//  ComponentsViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SnapKit

protocol ComponentsViewContorllerDelegate: AnyObject {
//    func componenstViewController(
//        _ viewController: ComponentsViewController,
//        didChoose component: Component
//    )
}

class ComponentsViewController: UIViewController {
    
    weak var delegate: ComponentsViewContorllerDelegate?
    
    private let listView = ListView(style: .insetGrouped)
    //private let components = Component.all
    
    //private var component: Component!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureViewController()
        configureListView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension ComponentsViewController {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Components"
    }
    
    func configureListView() {
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

//        for component in components {
//            let _view = IconInfoView(
//                icon: component.information.icon,
//                color: component.information.color,
//                title: component.information.name
//            )
//            listView.addView(_view)
//        }
    }
}

extension ComponentsViewController: ListViewDataSource, UITableViewDelegate {
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
        tableView.deselectRow(at: indexPath, animated: true)
        //let viewController = components[indexPath.section].information.viewController
        //navigationController?.pushViewController(viewController, animated: true)
        //viewController.delegate = self
    }
    
    func listView(
        _ listView: ListView,
        titleForFooterInSection section: Int
    ) -> String? {
        //return components[section].information.description
        return ""
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 5
    }
    
    func listView(
        _ listView: ListView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return " "
    }
}

extension ComponentsViewController: RightNavigationButtonable {
    func rightNavigationButtonDidTap() {
        //delegate?.componenstViewController(self, didChoose: component)
    }
    
    func rightNavigationButtonTitle() -> String? {
        return "done"
    }
}

extension ComponentsViewController: ComponentViewControllerDelegate {
//    func viewController(_ viewController: UIViewController, didReturn component: Component) {
//        delegate?.componenstViewController(self, didChoose: component)
//        self.dismiss(animated: true, completion: nil)
//    }
}
