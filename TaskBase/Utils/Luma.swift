//
//  Luma.swift
//  TaskBase
//
//  Created by Jeytery on 11.05.2022.
//

import UIKit

class Luma {
    static func forColor(_ color: UIColor) -> CGFloat {
        let red = CIColor(color: color).red
        let green = CIColor(color: color).green
        let blue = CIColor(color: color).blue
        let luma = ((0.2126 * red) + (0.7152 * green) + (0.0722 * blue))
        return luma
    }
    
    static func isDark(_ color: UIColor) -> Bool {
        if Luma.forColor(color) > 0.6 { return true }
        return false
    }
    
    static func isLight(_ color: UIColor) -> Bool {
        if Luma.forColor(color) > 0.6 { return false }
        return true
    }
    
    static func blackOrWhite(_ color: UIColor) -> UIColor {
        if Luma.forColor(color) > 0.6 { return .black }
        return .white
    }
}
