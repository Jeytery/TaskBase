//
//  Component.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import Foundation
import UIKit

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

// test

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
