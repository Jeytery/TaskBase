//
//  RepeaterViewController.swift
//  TaskBase
//
//  Created by Jeytery on 17.05.2022.
//

import UIKit
import SnapKit

class RepeaterCell: UIView {
    
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
        
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints() {
            $0.left.equalTo(iconView.snp.right).offset(15)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class RepeaterViewController: UIViewController, ListViewDataSource, UITableViewDelegate {
    
    private let listView = ListView(style: .insetGrouped)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(listView)
        listView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        let cell1 = RepeaterCell(icon: UIImage(systemName: "clock.fill")!, color: .systemRed, title: "Time")
        let cell2 = RepeaterCell(icon: UIImage(systemName: "repeat")!, color: .systemBlue, title: "Repeat Logic")
    
        listView.addViews([cell1, cell2])
        listView.listDataSource = self
        listView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Add time for your task"
        }
        
        if section == 1 {
            return "One in three days or only two days of week? :)"
        }
        
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? {
        
        return " "
    }
}


