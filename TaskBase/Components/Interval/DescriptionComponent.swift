//
//  DescriptionComponent.swift
//  TaskBase
//
//  Created by Jeytery on 08.06.2022.
//

import UIKit

struct DesriptionInput: Codable, Archivable {
    let name: String
    let description: String
}

class DescriptionComponent: Componentable {
    var information: ComponentInformation {
        return .init(
            name: "Description",
            description: "123",
            icon: UIImage(systemName: "scribble")!,
            color: .red,
            conflictedComponets: nil
        )
    }
    
    var id: ComponentId {
        return .description
    }
    
    var handler: ComponentHandler {
        return DescriptionComponentHandler()
    }
    
    var input: Data?
    
    var outputData: String {
        return "description"
    }
    
    var viewController: UIViewController & ComponentViewControllable {
        return IntervalViewController()
    }
}
