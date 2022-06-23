//
//  MultipleCellView.swift
//  TaskBase
//
//  Created by Jeytery on 09.06.2022.
//

import UIKit
import SnapKit

fileprivate class LinedCell: UIView {
    
    init(view: UIView) {
        super.init(frame: .zero)
        let line = UIView()
        line.backgroundColor = .systemGray5
        
        line.snp.makeConstraints() {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0.8)
        }
        
        addSubview(view)
        view.snp.makeConstraints() {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(line.snp.top)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

class MultipleCellView: UIView {
    
    enum Size {
        case autocomatic
        case fill
        case coeficient(Int)
    }
    
    private var views: [UIView] = []
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension MultipleCellView {
    func addView( size: Size, _ view: UIView) {
        
    }
}


