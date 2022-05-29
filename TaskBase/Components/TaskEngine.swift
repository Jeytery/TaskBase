//
//  TaskEngine.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import Foundation

typealias Tasks = [Task]

class TaskEngine {
    
    private let tasks: Tasks
    
    init(tasks: Tasks) {
        self.tasks = tasks
    }
}

extension TaskEngine {
    func getTodayTasks() -> Tasks {
        var returnTasks: Tasks = []
//        for task in tasks {
//            for apppearComponent in task.appearComponents {
//                if apppearComponent.shouldAppear {
//                    returnTasks.append(task)
//                    continue
//                }
//            }
//        }
        return returnTasks
    }
}
