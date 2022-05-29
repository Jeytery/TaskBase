//
//  IntervalComponent.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import Foundation
import UIKit

struct IntervalComponentInput {
    let interval: Int
    let time: Date
    let startDate: Date
}

struct IntervalComponentOutput {}

class IntervalComponent {
    
    private var input: IntervalComponentInput!
    private var lastDate: Date!
    
    init(_ input: IntervalComponentInput) {
        self.input = input
    }
}

private extension IntervalComponent {
    func storeLastDate(_ date: Date) {
        self.lastDate = date
    }
}

extension IntervalComponent: AppearComponentHandler {
    var shouldAppear: Bool {
        let today = Date()
        let startDate = input.startDate
        let interval = input.interval
        storeLastDate(today)
        return false
    }
}



