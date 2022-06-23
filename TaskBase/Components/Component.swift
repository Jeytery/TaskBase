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
