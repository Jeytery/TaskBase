//
//  Colors.swift
//  TaskBase
//
//  Created by Jeytery on 11.05.2022.
//

import UIKit

class Colors {
    static let green = Color(hex: "66D35D")
    static let mint = Color(hex: "5AD0C2")
    
    static let monochrome = Color("monochrome")
}

//MARK: - colors infrastructure
extension Colors {
    static func Color(_ name: String) -> UIColor {
        guard #available(iOS 11.0, *) else { return .white }
        return UIColor(named: name) ?? .white
    }
    
    static func Color(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat
    ) -> UIColor {
        return UIColor(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            alpha: 1
        )
    }
    
    static func Color(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

