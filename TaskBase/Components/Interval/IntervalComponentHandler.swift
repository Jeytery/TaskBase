//
//  IntervalComponentHandler.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import Foundation
import UIKit

struct IntervalComponentHandlerInput: Archivable {
    let interval: Int
    let time: Date
    
    struct Time {
        let minutes: Int
        let hours: Int
    }
    
    var timeStruct: Time {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        return Time(minutes: components.minute ?? 0, hours: components.hour ?? 0)
    }
}

class IntervalComponentHandler {
    
    private var lastDate: Date!
    private var originalDate: Date!
}

private extension IntervalComponentHandler {
    func storeLastDate(_ date: Date) {
        self.lastDate = date
    }
}

extension IntervalComponentHandler: AppearComponentHandler {
    func shouldAppear(data: Data) -> Bool {
        return false
    }
    
    var outputData: String {
        return "12:00, each 3 days"
    }
}



