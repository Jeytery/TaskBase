//
//  IntervalViewController.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import UIKit

protocol IntervalViewControllerDelegate: AnyObject {
//    func intervalViewController(
//        _ viewController: IntervalViewController,
//        didReturn intervalComponent: Component
//    )
}

class IntervalViewController: UIViewController, ComponentViewControllerable {
    
    weak var delegate: ComponentViewControllerDelegate?
    
    private let listView = ListView(style: .insetGrouped)
    
    private let timeIntervalView = TimeIntervalView()
    private let timeLogicView = IntervalLogicView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        listView.listDataSource = self
        listView.delegate = self
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        listView.addView(timeIntervalView)
        listView.addView(timeLogicView)
        configureRightNavigationButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension IntervalViewController: ListViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Add time for your task"
        }
        
        if section == 1 {
            return "One in three days or only two days of week? :)"
        }
        
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? {
        
        return " "
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension IntervalViewController: RightNavigationButtonable {
    func rightNavigationButtonDidTap() {
        let input = IntervalComponentHandlerInput(
            interval: 0,
            time: Date()
        )
        //let handler = IntervalComponentHandler(input)
//        delegate?.viewController(
//            self,
//            didReturn: .component(
//                information: Component.interval.information,
//                handler: handler
//            )
//        )
    }
    
    func rightNavigationButtonTitle() -> String? {
        return "done"
    }
}

extension IntervalViewController: ComponentViewControllable {
    func configure(data: Data) {}
}
