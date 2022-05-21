//
//  Component.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import Foundation

protocol Component {
    
    associatedtype Input
    associatedtype Output
    
    func input(_ input: Input)
    func output() -> Output
}

protocol AppearComponent: Component {
        
    var shouldAppear: Bool { get }
}


protocol DataComponent: Component {
    
    associatedtype ReturnDara
    
    func returnData() -> ReturnDara
}
