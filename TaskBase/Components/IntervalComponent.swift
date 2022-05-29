//
//  IntervalComponent.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import Foundation
import UIKit

struct IntervalComponentHandlerInput {
    let interval: Int
    let time: Date
}

class IntervalComponentHandler {
    
    private var input: IntervalComponentHandlerInput!
    
    private var lastDate: Date!
    private var originalDate: Date!
    
    init(_ input: IntervalComponentHandlerInput) {
        self.input = input
    }
}

private extension IntervalComponentHandler {
    func storeLastDate(_ date: Date) {
        self.lastDate = date
    }
}

extension IntervalComponentHandler: AppearComponentHandler {
    var shouldAppear: Bool {
        let today = Date()
        let interval = input.interval
        storeLastDate(today)
        return false
    }
    
    var outputData: String {
        return "12:00, each 3 days"
    }
}



