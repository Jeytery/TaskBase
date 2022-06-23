//
//  IntervalViewController.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import UIKit
import SPDiffable

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Interval"
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

class ___IntervalViewController: SPDiffableTableController, ComponentViewControllable, SPDiffableTableMediator {
    
    private var timeWrapper = false {
        didSet {
            updateContent(animated: true)
        }
    }
    
    var content: [SPDiffableSection] {
        let timeRows: [SPDiffableTableRow] = [
            .init(
                text: "Time",
                detail: nil,
                icon: UIImage.generateSettingsIcon(
                    "clock.fill",
                    backgroundColor: .systemBlue
                ),
                accessoryType: .disclosureIndicator,
                selectionStyle: .default,
                action: {
                    [unowned self] _, _ in
                    self.timeWrapper.toggle()
                }
            )
        ]
        
        let timeSection = SPDiffableSection(
            id: "1",
            header: nil,
            footer: nil,
            items: timeRows
        )
        
        if timeWrapper {
            timeSection.items.insert(
                SPDiffableWrapperItem(id: "cell", model: 1, action: nil),
                at: 1
            )
        }
        
        
        let intervalRows: [SPDiffableTableRow] = [
            .init(
                text: "Interval",
                detail: nil,
                icon: UIImage.generateSettingsIcon(
                    "clock.arrow.2.circlepath",
                    backgroundColor: .systemRed
                ),
                accessoryType: .disclosureIndicator,
                selectionStyle: .default,
                action: nil
            )
        ]
        
        let intervalSection = SPDiffableSection(
            id: "2",
            header: nil,
            footer: nil,
            items: intervalRows
        )
        
        return [timeSection, intervalSection]
    }
    
    init() {
        super.init(style: .insetGrouped)
        
        title = "Interval"
        
        tableView.delegate = self
        
        tableView.register(
            ViewableTableViewCell<TimeIntervalView>.self,
            forCellReuseIdentifier: "cell"
        )
        
        let customProvider = SPDiffableTableDataSource.CellProvider() {
            (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
        
        diffableDataSource?.mediator = self
        
        configureDiffable(
            sections: content,
            cellProviders: SPDiffableTableDataSource.CellProvider.default + [customProvider]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateContent(animated: Bool) {
        diffableDataSource?.set(content, animated: animated)
    }

    func configure(data: Data) {
            
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0, indexPath.row == 1 {
            return 75
        }
        
        return 60
    }
}
