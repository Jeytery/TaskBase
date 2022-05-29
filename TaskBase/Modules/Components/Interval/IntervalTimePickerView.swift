//
//  IntervalTimePickerView.swift
//  TaskBase
//
//  Created by Jeytery on 29.05.2022.
//

import UIKit
import SnapKit

protocol IntervalTimePickerViewDelegate: AnyObject {
    func repeaterTimerViewController(
        _ viewController: RepeaterTimeViewController,
        didPick hours: Int,
        minutes: Int
    )
}

class IntervalTimePickerView: UIView {
    
    weak var delegate: IntervalTimePickerViewDelegate?
    
    private(set) var hours: Int = 0
    private(set) var minutes: Int = 0
    
    private let stackView = UIStackView()
    private let hoursPicker = UIPickerView()
    private let minutesPicker = UIPickerView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        configureStackView()
        configureDelegates()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension IntervalTimePickerView {
    func configureDelegates() {
        hoursPicker.dataSource = self
        minutesPicker.dataSource = self
        hoursPicker.delegate = self
        minutesPicker.delegate = self
    }
    
    func configureStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints() {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.4)
            $0.height.equalToSuperview().dividedBy(2)
        }
        
        stackView.addArrangedSubview(hoursPicker)
        stackView.addArrangedSubview(minutesPicker)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
}

extension IntervalTimePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == minutesPicker {
            return 60
        }
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row < 10 {
            return "0" + String(row)
        }
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == hoursPicker {
            self.hours = row
        }
        else {
            self.minutes = row
        }
    }
}
