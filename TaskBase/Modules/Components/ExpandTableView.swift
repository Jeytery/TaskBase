//
//  ExpandTableView.swift
//  TaskBase
//
//  Created by Jeytery on 18.05.2022.
//

import UIKit
import SnapKit

class ExpandTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ExpandTableView {
    func addView(_ view: UIView) {
        
    }
    
    
}
