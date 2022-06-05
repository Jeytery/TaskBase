//
//  Component.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import Foundation
import UIKit

//MARK: - working version

/*
enum ComponentType {
    case appear
    case data
}

struct Component {
    
    let information: ComponentInformation
    
    var handler: ComponentHandler!
    
    mutating func setHandler(_ handler: ComponentHandler) {
        self.handler = handler
    }
    
    // interval
    static let interval = Component(
        information: ComponentInformation(
            id: 0,
            name: "Interval",
            description: "1 desc",
            icon: UIImage(systemName: "repeat")!,
            color: .systemBlue,
            conflictedComponets: nil,
            componentType: .appear,
            viewController: IntervalViewController()
        )
    )
   
    // description
    static let description = Component(
        information: ComponentInformation(
            id: 1,
            name: "Description",
            description: "1 desc",
            icon: UIImage(systemName: "highlighter")!,
            color: .systemBlue,
            conflictedComponets: nil,
            componentType: .appear,
            viewController: IntervalViewController()
        )
    )
    
    static func component(information: ComponentInformation, handler: ComponentHandler) -> Component {
        let component = Component(information: information, handler: handler)
        return component
    }
    
    static var all: [Component] {
        return [.interval, .description]
    }
}

struct ComponentInformation: Identifiable {
    let id: Int
    let name: String
    let description: String
    let icon: UIImage
    let color: UIColor
    let conflictedComponets: [Component]?
    let componentType: ComponentType
    let viewController: ComponentViewControllerable
}

protocol ComponentHandler {
    var outputData: String { get }
}

protocol AppearComponentHandler: ComponentHandler {
    var shouldAppear: Bool { get }
}

protocol DataComponentHandler: ComponentHandler {
    func getDataView() -> UIView
}
*/

//MARK: -  test 1

/*
struct __ComponentInformation: Identifiable {
    let id: Int
    let name: String
    let description: String
    let icon: UIImage
    let color: UIColor
    let conflictedComponets: [__ComponentInformation]?
    let componentType: ComponentType
    
    static let description = __ComponentInformation(
       id: 0,
       name: "Description",
       description: "1 desc",
       icon: UIImage(systemName: "highlighter")!,
       color: .systemBlue,
       conflictedComponets: nil,
       componentType: .appear
   )
    
    static let interval = __ComponentInformation(
        id: 1,
        name: "Description",
        description: "1 desc",
        icon: UIImage(systemName: "highlighter")!,
        color: .systemBlue,
        conflictedComponets: nil,
        componentType: .appear
    )
}

struct __Component<RootViewControllerType: UIViewController> {
    
    private(set) var information: __ComponentInformation
    
    private(set) var handler: ComponentHandler!
    
    var rootViewController: RootViewControllerType {
        return RootViewControllerType()
    }
    
    mutating func setHandler(_ handler: ComponentHandler) {
        self.handler = handler
    }

    init(information: __ComponentInformation) {
        self.information = information
    }
}

struct UnhadledComponent {
    static let interval: __Component<IntervalViewController> = __Component(information: .interval)
    static let description: __Component<UIViewController> = __Component(information: .description)
    
    static func handledComponent<RootViewControllerType: UIViewController>(
        component: __Component<RootViewControllerType>,
        handler: ComponentHandler
    ) -> __Component<RootViewControllerType> {
        var _component = component
        _component.setHandler(handler)
        return _component
    }
}

func HandledComponent<RootViewController: UIViewController>(
    component: __Component<RootViewController>,
    handler: ComponentHandler
) -> __Component<RootViewController> {
    var _component = component
    _component.setHandler(handler)
    return _component
}

typealias IntervalComponent = __Component<IntervalViewController>
*/



//MARK: - test 2

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

protocol ComponentHandler {}

protocol AppearComponentHandler: ComponentHandler {
    var shouldAppear: Bool { get }
}

protocol ViewComponentHandler: ComponentHandler {
    var view: UIView { get }
}

protocol Componentable {
    
    var information: ComponentInformation { get }
    var id: ComponentId { get }
    
    var handler: ComponentHandler { get }
    
    var input: Data? { get set }
    var outputData: String { get }
    
    var viewController: UIViewController { get }
}

typealias NoinputComponenet = Componentable
typealias InputedComponent = Componentable

class IntervalComponent: Componentable {
    
    var information: ComponentInformation {
        return .init(
            name: "Interval",
            description: "Some interval description",
            icon: UIImage(systemName: "clock.fill")!,
            color: .systemBlue,
            conflictedComponets: nil
        )
    }
    
    var handler: ComponentHandler {
        return IntervalComponentHandler()
    }
    
    var id: ComponentId {
        return .interval
    }
    
    var input: Data?
    
    var outputData: String {
        return ""
    }
    
    var viewController: UIViewController {
        return UIViewController()
    }
}

class DescriptionComponentHandler: ViewComponentHandler {
    var view: UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
}


struct DesriptionInput: Codable, Archivable {
    let name: String
    let description: String
}

class DescriptionComponent: Componentable {
    var information: ComponentInformation {
        return .init(
            name: "Description",
            description: "123",
            icon: UIImage(systemName: "scribble")!,
            color: .red,
            conflictedComponets: nil
        )
    }
    
    var id: ComponentId {
        return .description
    }
    
    var handler: ComponentHandler {
        return DescriptionComponentHandler()
    }
    
    var input: Data?
    
    var outputData: String {
        return "description"
    }
    
    var viewController: UIViewController {
        return UIViewController()
    }
}

struct Task {
    var components: [Componentable]
    
    var descriptionComponent: Componentable {
        for component in components {
            if component.id == .description {
                return component
            }
        }
        return components[0]
    }
    
    var compepntsId: [Int] {
        return components.compactMap {
            return $0.id.rawValue
        }
    }
    
    mutating func addComponent(_ component: Componentable) {
        
    }
    
    mutating func removeComponent(at index: Int) {
        
    }
    
    var shouldAppear: Bool {
        for component in components {
            guard let handler = component.handler as? AppearComponentHandler else {
                continue
            }
            if handler.shouldAppear {
                return true
            }
        }
        return false
    }
    
    var componentViews: [UIView] {
        var views: [UIView] = []
        for component in components {
            guard let handler = component.handler as? ViewComponentHandler else {
                continue
            }
            views.append(handler.view)
        }
        return views
    }
}


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
