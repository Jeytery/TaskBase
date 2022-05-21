//
//  TaskViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit

class BigRepeaterView: UIView {
    
    private let labelStackView = UIStackView()
        
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    
    private let colorView = UIView()
    
    init(icon: UIImage, color: UIColor, title: String) {
        super.init(frame: .zero)
        
        colorView.addSubview(iconView)
        iconView.snp.makeConstraints() {
            $0.height.width.equalToSuperview().dividedBy(1.35)
            $0.center.equalToSuperview()
        }
        iconView.contentMode = .scaleAspectFit
        iconView.image = icon
        
        iconView.tintColor = .white
        
        addSubview(colorView)
        colorView.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.height.equalToSuperview().dividedBy(2)
            $0.width.equalTo(colorView.snp.height)
        }
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 10
        
        
        addSubview(labelStackView)
        labelStackView.snp.makeConstraints() {
            $0.left.equalTo(iconView.snp.right).offset(15)
            $0.centerY.equalToSuperview()
        }
        
        labelStackView.axis = .vertical
    
        labelStackView.addArrangedSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class TaskViewController: UIViewController {
    
    private let listView = ListView(style: .insetGrouped)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        title = "Task"
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        let nameView = IconInfoView(icon: UIImage(systemName: "highlighter")!, color: .systemRed, title: "Information")
        listView.addView(nameView)
        
        nameView.showSubtitle("Clean room, Get the fuck up and clean room")
        nameView.lock()
        
        let repeaterView = IconInfoView(
            icon: UIImage(systemName: "repeat")!,
            color: .systemBlue,
            title: "Repeater"
        )
        
        repeaterView.showSubtitle("12:00, Each 3 days")
        
        listView.addView(repeaterView)
        
        configureLeftNavigationButton()
        configureRightNavigationButton()
        
        listView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TaskViewController: RightNavigationButtonable {
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .add
    }
    
    func rightNavigationButtonDidTap() {
        let nc = UINavigationController(rootViewController: ComponentsViewController())
        present(nc, animated: true, completion: nil)
    }
}

extension TaskViewController: LeftNavigationButtonable {
    func leftNavigationButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func leftNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return .close
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
