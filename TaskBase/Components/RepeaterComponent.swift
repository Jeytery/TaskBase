//
//  RepeaterComponent.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import Foundation

struct RepeaterComponentInput {
    
}

struct RepeaterComponentOutput {}

struct RepeaterComponent: AppearComponent {
    
    var shouldAppear: Bool {
        return false
    }
    
    typealias Input = RepeaterComponentInput
    typealias Output = RepeaterComponentOutput
    
    func input(_ input: RepeaterComponentInput) {
            
    }
    
    func output() -> RepeaterComponentOutput {
        return RepeaterComponentOutput()
    }
}
