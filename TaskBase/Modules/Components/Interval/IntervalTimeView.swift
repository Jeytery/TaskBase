//
//  IntervalTimeView.swift
//  TaskBase
//
//  Created by Jeytery on 29.05.2022.
//

import UIKit
import SnapKit

class TimeIntervalView: UIView {
    
    private let timeInfoView = IconInfoView(
        icon: UIImage(systemName: "clock.fill")!,
        color: .systemRed,
        title: "Time"
    )

    private let timePickerView = IntervalTimePickerView()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(timeInfoView)
        addSubview(timePickerView)
        
        timeInfoView.snp.makeConstraints() {
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.3)
        }
        
        timePickerView.snp.makeConstraints() {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(timeInfoView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var height: CGFloat {
        return 100
    }
}
