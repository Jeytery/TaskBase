//
//  TasksService.swift
//  TaskBase
//
//  Created by Jeytery on 05.06.2022.
//

import Foundation
import UIKit

class TasksService {
    
    private struct TaskBaseInformation: Codable {
        let components: [ComponentBaseInformation]
    }
    
    private let key = "tasks.key"
    
    private struct ComponentBaseInformation: Codable {
        let id: Int
        let input: Data
    }
    
    private func baseComponents(_ components: [Componentable]) -> [ComponentBaseInformation] {
        return components.compactMap {
            return .init(id: $0.id.rawValue, input: $0.input!)
        }
    }
    
    private func baseTasks(_ tasks: [Task]) -> [TaskBaseInformation] {
        return tasks.compactMap {
            return .init(
                components: baseComponents($0.components)
            )
        }
    }
    
    func saveTasksToDevice(_ tasks: [Task]) {
        let baseTasks = baseTasks(tasks)
        guard let data = try? JSONEncoder().encode(baseTasks) else {
            print("DATA from BASE_TASKS is nil")
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func saveTask(_ task: Task) {
        var baseComponents: [ComponentBaseInformation] = []
        for component in task.components {
            guard let input = component.input else { return }
            let baseComponent = ComponentBaseInformation(id: component.id.rawValue, input: input)
            baseComponents.append(baseComponent)
        }
        let taskBaseInfo = TaskBaseInformation(components: baseComponents)
        UserDefaults.standard.set(taskBaseInfo, forKey: "task.key")
    }

    func getTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "tasks.key") else {
            print("DATA by key 'tasks.key' is nil")
            return []
        }
        
        guard let tasks = try? JSONDecoder().decode([TaskBaseInformation].self, from: data) else {
            print("Tasks from deconding data is nil")
            return []
        }
        
        return tasks.compactMap() {
            let components: [Componentable] = $0.components.compactMap {
                return Component(by: $0.id, input: $0.input)
            }
            return .init(components: components)
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
