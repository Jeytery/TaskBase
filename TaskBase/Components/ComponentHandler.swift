//
//  ComponentHandler.swift
//  TaskBase
//
//  Created by Jeytery on 08.06.2022.
//

import Foundation
import UIKit

protocol ComponentHandler {}

protocol AppearComponentHandler: ComponentHandler {
    func shouldAppear(data: Data) -> Bool
}

protocol ViewComponentHandler: ComponentHandler {
    func view(data: Data) -> UIView
}
