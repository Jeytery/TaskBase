//
//  CircleView.swift
//  TaskBase
//
//  Created by Jeytery on 11.05.2022.
//

import UIKit

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
