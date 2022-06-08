//
//  Task.swift
//  TaskBase
//
//  Created by Jeytery on 08.06.2022.
//

import Foundation
import UIKit

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
    
    static let empty = Task(components: [])
}
