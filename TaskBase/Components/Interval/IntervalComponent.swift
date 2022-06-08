//
//  IntervalComponent.swift
//  TaskBase
//
//  Created by Jeytery on 08.06.2022.
//

import Foundation
import UIKit

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
    
    var viewController: UIViewController & ComponentViewControllable {
        return IntervalViewController()
    }
}
