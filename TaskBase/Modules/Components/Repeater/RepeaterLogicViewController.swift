//
//  RepeaterLogicViewController.swift
//  TaskBase
//
//  Created by Jeytery on 18.05.2022.
//

import UIKit
import SnapKit

fileprivate class DayView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        backgroundColor = .tertiarySystemFill
        
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

fileprivate class WeekView: UIView {
    
}

fileprivate class CalendarView: UIView {
    
}

enum RepeaterLogic: String {
    case each = "Each 5 days"
    case calendar = "Calendar"
}

protocol RepeaterLogicViewControllerDelegate: AnyObject {
    func repeaterLogicViewController(_ viewController: UIViewController, didPick option: RepeaterLogic)
}

class RepeaterLogicViewController: UIViewController {
    
    weak var delegate: RepeaterLogicViewControllerDelegate?
    
    private let segmentControl = UISegmentedControl(items: ["Period", "Week", "Calendar"])
    
    init() {
        super.init(nibName: nil, bundle: nil)
      
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints() {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(50)
        }
        
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.addTarget(self, action: #selector(segmentControlValueDidChange), for: .valueChanged)
        
        view.backgroundColor = .systemBackground
        
        configureRightNavigationButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func segmentControlValueDidChange() {
        if segmentControl.selectedSegmentIndex == 0 {
            let dayView = DayView()
            view.addSubview(dayView)
            
            dayView.snp.makeConstraints() {
                $0.top.equalTo(segmentControl.snp.bottom).offset(20)
                $0.left.equalTo(segmentControl.snp.left)
                $0.right.equalTo(segmentControl.snp.right)
                $0.height.equalToSuperview().dividedBy(2.2)
            }
        }
    }
}

extension RepeaterLogicViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .done
    }
    
    func rightNavigationButtonDidTap() {
        delegate?.repeaterLogicViewController(
            self,
            didPick: .each
        )
    }
}

