//
//  IntervalViewController.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import UIKit
import SPDiffable
import _Lister

protocol IntervalViewControllerDelegate: AnyObject {
    func intervalViewController(
        _ viewController: IntervalViewController,
        didReturn intervalComponent: Componentable
    )
}
//
//class IntervalViewController: UIViewController {
//
//    weak var delegate: IntervalViewControllerDelegate?
//
//    private let listView = ListView(style: .insetGrouped)
//
//    private let timeIntervalView = TimeIntervalView()
//    private let timeLogicView = IntervalLogicView()
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//
//        listView.listDataSource = self
//        listView.delegate = self
//
//        view.addSubview(listView)
//        listView.snp.makeConstraints() {
//            $0.edges.equalToSuperview()
//        }
//
//        listView.addView(timeIntervalView)
//        listView.addView(timeLogicView)
//        configureRightNavigationButton()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.largeTitleDisplayMode = .never
//        title = "Interval"
//    }
//}
//
//extension IntervalViewController: ListViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
//
//    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? {
//        if section == 0 {
//            return "Add time for your task"
//        }
//
//        if section == 1 {
//            return "One in three days or only two days of week? :)"
//        }
//
//        return " "
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 7
//    }
//
//    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? {
//        return " "
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//extension IntervalViewController: RightNavigationButtonable {
//    func rightNavigationButtonDidTap() {
//        let input = IntervalComponentHandlerInput(
//            interval: 0,
//            time: Date()
//        )
//
//        let component = IntervalComponent()
//        component.input = input.archive()
//
//        delegate?.intervalViewController(self, didReturn: IntervalComponent())
//    }
//
//    func rightNavigationButtonTitle() -> String? {
//        return "done"
//    }
//}
//
//extension IntervalViewController: ComponentViewControllable {
//    private func getMinutes(date: Date) -> Int {
//        let calendar = NSCalendar.current
//        let components = calendar.dateComponents([.minute], from: date)
//        return components.hour ?? 0
//    }
//
//    private func getHours(date: Date) -> Int {
//        let calendar = NSCalendar.current
//        let components = calendar.dateComponents([.hour], from: date)
//        return components.hour ?? 0
//    }
//
//    func configure(data: Data) {
//        let input = IntervalComponentHandlerInput.unarchive(data: data)
//        timeLogicView.setInterval(input.interval)
//        let date = input.time
//        timeIntervalView.setTime(
//            minutes: getMinutes(date: date),
//            hours: getHours(date: date)
//      q  )
//    }
//}

class IntervalViewController: UIViewController, ComponentViewControllable {
    
    private let lister = Lister(frame: .zero, style: .insetGrouped)
    
    private let timeCell = IconInfoView(
        icon: UIImage(systemName: "clock.fill")!,
        color: .systemBlue,
        title: "Time"
    )
    
    private let logicCell = IconInfoView(
        icon: UIImage(systemName: "repeat.circle.fill")!,
        color: .systemRed,
        title: "Interval"
    )
    
    private let timeIntervalView = TimeIntervalView()
    private let timeLogicView = IntervalLogicView()
    
    private var timeCellTrigger: Bool = false {
        didSet {
            if timeCellTrigger {
                lister.appendRow(
                    .init(view: timeIntervalView, height: 150, edges: nil, action: nil),
                    section: 0
                )
            }
            else {
                lister.removeRow(
                    at: .init(row: 1, section: 0)
                )
            }
        }
    }
    
    private var logicCellTrigger: Bool = false {
        didSet {
            if logicCellTrigger {
                lister.appendRow(
                    .init(view: timeLogicView, height: 150, edges: nil, action: nil),
                    section: 1
                )
            }
            else {
                lister.removeRow(
                    at: .init(row: 1, section: 1)
                )
            }
        }
    }
    
    private lazy var content: [ListerSection] = [
        .init(
            rows: [
                .init(view: timeCell, height: 60, edges: nil) {
                    self.timeCellTrigger.toggle()
                }
            ],
            header: "Set your time",
            footer: "tap on cell"
        ),
        .init(
            rows: [
                .init(view: logicCell, height: 60, edges: nil) {
                    self.logicCellTrigger.toggle()
                }
            ],
            header: "",
            footer: ""
        )
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Interval"
        
        view.addSubview(lister)
        lister.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        lister.set(content)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(data: Data) {
            
    }
}
