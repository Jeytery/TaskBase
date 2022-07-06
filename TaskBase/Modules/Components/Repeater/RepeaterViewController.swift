//
//  RepeaterViewController.swift
//  TaskBase
//
//  Created by Jeytery on 17.05.2022.
//

import UIKit
import SnapKit
import _Lister

class RepeaterViewController: UIViewController, ListViewDataSource, UITableViewDelegate {
    
    private let listView = ListView(style: .insetGrouped)
    private let lister = Lister(frame: .zero, style: .insetGrouped)
    
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
//        listView.snp.makeConstraints() {
//            $0.edges.equalToSuperview()
//        }
//        
//        listView.addViews(
//            [timeCell, repeaterLogicCell]
//        )
//        
//        listView.listDataSource = self
//        listView.delegate = self
//        listView.allowsSelection = true
        
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
        
        if indexPath.section == 0 {
            let vc = RepeaterTimeViewController()
            vc.delegate = self
            let nc = UINavigationController(rootViewController: vc)
            present(nc, animated: true, completion: nil)
        }
        
        if indexPath.section == 1 {
            let vc = RepeaterLogicViewController()
            vc.delegate = self
            let nc = UINavigationController(rootViewController: vc)
            present(nc, animated: true, completion: nil)
        }
    }
}

extension RepeaterViewController: RepeaterLogicViewControllerDelegate {
    func repeaterLogicViewController(_ viewController: UIViewController, didPick option: RepeaterLogic) {
        viewController.dismiss(animated: true, completion: nil)
        repeaterLogicCell.showSubtitle(option.rawValue)
    }
}

extension RepeaterViewController: RepeaterTimeViewControllerDelegate {
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

