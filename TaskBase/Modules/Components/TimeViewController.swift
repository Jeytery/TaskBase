//
//  TimeViewController.swift
//  TaskBase
//
//  Created by Jeytery on 22.05.2022.
//

import UIKit
import SnapKit

protocol TimeViewControllerDelegate: AnyObject {
    func timeViewController(
        _ viewController: TimeViewController,
        didPick hours: Int,
        minutes: Int
    )
}

class TimeViewController: UIViewController {
    
    weak var delegate: TimeViewControllerDelegate?
    
    private let stackView = UIStackView()
    
    private let hoursPicker = UIPickerView()
    private let minutesPicker = UIPickerView()
    
    private var hours = 0
    private var minutes = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints() {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.4)
            $0.height.equalToSuperview().dividedBy(2)
        }
        
        stackView.addArrangedSubview(hoursPicker)
        stackView.addArrangedSubview(minutesPicker)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        hoursPicker.dataSource = self
        minutesPicker.dataSource = self
        
        hoursPicker.delegate = self
        minutesPicker.delegate = self
        
        title = "Time"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(a)
        )
    }
    
    @objc func a() {
        delegate?.timeViewController(self, didPick: hours, minutes: minutes)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TimeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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



