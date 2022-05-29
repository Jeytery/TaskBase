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
   
    static func interval(handler: IntervalComponentHandler) -> Component {
        var component: Component = .interval
        component.setHandler(handler)
        return component
    }
    
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
            viewController: UIViewController()
        )
    )
    
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
    let viewController: UIViewController
}

protocol ComponentHandler {}

protocol AppearComponentHandler: ComponentHandler {
    var shouldAppear: Bool { get }
}

protocol DataComponentHandler: ComponentHandler {
    func getDataView() -> UIView
}














//MARK: - test

struct __ComponentInformation: Identifiable {
    let id: Int
    let name: String
    let description: String
    let icon: UIImage
    let color: UIColor
    let conflictedComponets: [__ComponentID]?
    let componentType: ComponentType
    let viewController: UIViewController
}

enum __ComponentID: Int {
    case interval = 0
    case description = 1
}

protocol ComponentInformationnable {
    static var information: __ComponentInformation { get }
}

class __IntervalComponentHandler: AppearComponentHandler {
    var shouldAppear: Bool {
        return false
    }
}

extension __IntervalComponentHandler: ComponentInformationnable {
    static var information = __ComponentInformation(
        id: 0,
        name: "",
        description: "",
        icon: UIImage(),
        color: .red,
        conflictedComponets: [.interval, .description],
        componentType: .appear,
        viewController: UIViewController()
    )
}



