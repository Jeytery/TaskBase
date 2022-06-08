//
//  IntervalLogicView.swift
//  TaskBase
//
//  Created by Jeytery on 29.05.2022.
//

import UIKit
import SnapKit

class IntervalLogicView: UIView {
    
    private let titles: [String] = [
        "Each day",
        "Each 2 days",
        "Each 3 days",
        "Each 4 days",
        "Each 5 days",
        "Each 6 days",
        "Each week",
        "Each month"
    ]
    
    private let pickerView = UIPickerView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        layer.cornerRadius = 10
        
        addSubview(pickerView)
        pickerView.snp.makeConstraints() {
            $0.top.left.equalToSuperview().offset(10)
            $0.right.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setInterval(_ interval: Int) {
        var _interval = interval
        if interval > 7 {
            _interval = 8
        }
        pickerView.selectRow(
            _interval - 1,
            inComponent: 0,
            animated: false
        )
    }
}

extension IntervalLogicView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return titles.count
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return titles[row]
    }
    
    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return 1
    }
}
