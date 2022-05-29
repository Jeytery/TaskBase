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
        didReturn intervalComponent: IntervalComponent
    )
}

class IntervalViewController: UIViewController, ListViewDataSource, UITableViewDelegate {
    
    weak var delegate: IntervalViewControllerDelegate?
    
    private let listView = ListView(style: .insetGrouped)
    
    private let timeCell = IconInfoView(
        icon: UIImage(systemName: "clock.fill")!,
        color: .systemRed,
        title: "Time"
    )
    
    private let repeaterLogicCell = IconInfoView(
        icon: UIImage(systemName: "repeat")!,
        color: .systemBlue,
        title: "Repeat Logic"
    )
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        listView.addViews(
            [timeCell, repeaterLogicCell]
        )
        
        listView.listDataSource = self
        listView.delegate = self
        listView.allowsSelection = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(a)
        )
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func a() {}
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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

extension IntervalViewController: RepeaterLogicViewControllerDelegate {
    func repeaterLogicViewController(_ viewController: UIViewController, didPick option: RepeaterLogic) {
        viewController.dismiss(animated: true, completion: nil)
        repeaterLogicCell.showSubtitle(option.rawValue)
    }
}

extension IntervalViewController: RepeaterTimeViewControllerDelegate {
    func repeaterTimerViewController(
        _ viewController: RepeaterTimeViewController,
        didPick hours: Int,
        minutes: Int
    ) {
        viewController.dismiss(animated: true, completion: nil)
        
        var hoursString = ""
        var minutesString = ""
        
        if hours < 10 {
            hoursString = "0" + String(hours)
        }
        else {
            hoursString = String(hours)
        }
        
        if minutes < 10 {
            minutesString = "0" + String(minutes)
        }
        else {
            minutesString = String(minutes)
        }
        
        timeCell.showSubtitle(hoursString + ":" + minutesString)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}


fileprivate class TimeIntervalView: UIView {
    
    private let timeInfoView = IconInfoView(
        icon: UIImage(systemName: "clock.fill")!,
        color: .systemRed,
        title: "Time"
    )

    private let timePickerView = IntervalTimePickerView()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class __IntervalViewController: UIViewController {
    
    private let listView = ListView(style: .insetGrouped)
    
    private let timeIntervalView = TimeIntervalView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureRightNavigationButton()
        
        listView.listDataSource = self
        listView.delegate = self
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        listView.addView(timeIntervalView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension __IntervalViewController: ListViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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

extension __IntervalViewController: RightNavigationButtonable {
    func rightNavigationButtonStyle() -> UIBarButtonItem.Style {
        return .done
    }
    
    func rightNavigationButtonDidTap() {
            
    }
}
