//
//  Component.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import Foundation
import UIKit

protocol Componentable {
    
    var information: ComponentInformation { get }
    var id: ComponentId { get }
    
    var handler: ComponentHandler { get }
    
    var input: Data? { get set }
    var outputData: String { get }
    
    var viewController: UIViewController & ComponentViewControllable { get }
}

protocol ComponentViewControllable {
    func configure(data: Data)
}

struct ComponentInformation {
    let name: String
    let description: String
    let icon: UIImage
    let color: UIColor
    let conflictedComponets: [ComponentId]?
}

enum ComponentId: Int {
    case interval = 0
    case description = 1
    case binder = 2
}

typealias NoinputComponenet = Componentable
typealias InputedComponent = Componentable

func Component(by id: Int) -> NoinputComponenet? {
    switch id {
    case 0:
        return IntervalComponent()
    case 1:
        return DescriptionComponent()
    default:
        return nil
    }
}

func Component(by id: Int, input: Data) -> InputedComponent? {
    var component = Component(by: id)
    component?.input = input
    return component
}























class __TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    private let task: Task
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.components.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
        
        let component = task.components[indexPath.row]
        
        cell.baseView.configure(
            icon: component.information.icon,
            color: component.information.color,
            title: component.information.name
        )
        cell.baseView.showSubtitle(component.outputData)
        return cell
    }
    
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.register(
            ViewableTableViewCell<IconInfoView>.self,
            forCellReuseIdentifier: "cell"
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class __TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return tasks.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! ViewableTableViewCell<IconInfoView>
        
        let task = tasks[indexPath.row]
        
        if let input = task.descriptionComponent.input {
            let info = DesriptionInput.unarchive(data: input)
            cell.baseView.configure(
                icon: UIImage(systemName: "sribble.fill")!,
                color: .red,
                title: info.description
            )
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let task = tasks[indexPath.row]
        let vc = UINavigationController(rootViewController: __TaskViewController(task: task))
        present(vc, animated: true, completion: nil)
    }
    
    private var tasks: [Task] = []
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTableView()
        
        let interval = IntervalComponent()
        let desc = DescriptionComponent()

        interval.input = Data()
        desc.input = DesriptionInput(name: "Уборка", description: "ДЖ").archive()

        let task1Components: [Componentable] = [interval, desc]
        let task1 = Task(components: task1Components)

        let task2 = Task(components: [interval, interval])

        let tasksService = TasksService()
        tasksService.saveTasksToDevice([task1, task2])
        
        self.tasks = tasksService.getTasks()
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.register(
            ViewableTableViewCell<IconInfoView>.self,
            forCellReuseIdentifier: "cell"
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
}
