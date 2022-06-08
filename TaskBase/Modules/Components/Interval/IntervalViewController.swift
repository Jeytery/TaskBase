//
//  IntervalViewController.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import UIKit

protocol IntervalViewControllerDelegate: AnyObject {
    func intervalViewController(
        _ viewController: IntervalViewController,
        didReturn intervalComponent: Componentable
    )
}

class IntervalViewController: UIViewController {

    weak var delegate: IntervalViewControllerDelegate?
    
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
        
        let component = IntervalComponent()
        component.input = input.archive()
        
        delegate?.intervalViewController(self, didReturn: IntervalComponent())
    }
    
    func rightNavigationButtonTitle() -> String? {
        return "done"
    }
}

extension IntervalViewController: ComponentViewControllable {
    private func getMinutes(date: Date) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.minute], from: date)
        return components.hour ?? 0
    }
    
    private func getHours(date: Date) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: date)
        return components.hour ?? 0
    }
    
    func configure(data: Data) {
        let input = IntervalComponentHandlerInput.unarchive(data: data)
        timeLogicView.setInterval(input.interval)
        let date = input.time
        timeIntervalView.setTime(
            minutes: getMinutes(date: date),
            hours: getHours(date: date)
        )
    }
}
