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
        
//        timeInfoView.snp.makeConstraints() {
//            $0.top.left.right.equalToSuperview()
//            $0.height.equalToSuperview().dividedBy(4)
//        }
        
        timePickerView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var height: CGFloat {
        return 100
    }
    
    func setTime(minutes: Int, hours: Int) {
        timePickerView.setTime(minutes: minutes, hours: hours)
    }
}
