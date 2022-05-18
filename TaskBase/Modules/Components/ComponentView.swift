//
//  ComponentView.swift
//  TaskBase
//
//  Created by Jeytery on 11.05.2022.
//

import UIKit
import SnapKit

fileprivate class ColorView: CircleView {
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    
    init(color: UIColor, icon: UIImage, title: String) {
        super.init(frame: .zero)
        iconView.image = icon
        addSubview(iconView)
        iconView.snp.makeConstraints() {
            $0.left.equalToSuperview().offset(10)
            $0.height.equalToSuperview().dividedBy(1.7)
            $0.width.equalToSuperview().dividedBy(4)
            $0.centerY.equalToSuperview()
        }
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Colors.monochrome
        
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = Colors.monochrome
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints() {
            $0.left.equalTo(iconView.snp.right).offset(2.5)
            $0.centerY.equalToSuperview()
        }
        
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ComponentView: UIView {
    
    private let colorView: ColorView
    private let titleLabel = UILabel()
    
    init(color: UIColor, icon: UIImage, title: String, componentName: String) {
        colorView = ColorView(color: color, icon: icon, title: componentName)
        super.init(frame: .zero)
        
        addSubview(colorView)
        colorView.snp.makeConstraints() {
            $0.left.top.equalToSuperview().offset(20)
            $0.height.equalTo(40)
            $0.width.equalToSuperview().dividedBy(2.3)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints() {
            $0.top.equalTo(colorView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        titleLabel.textColor = .darkGray
        
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
