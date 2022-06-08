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
    var shouldAppear: Bool { get }
}

protocol ViewComponentHandler: ComponentHandler {
    var view: UIView { get }
}
