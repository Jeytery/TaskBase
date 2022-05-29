//
//  IconInfoView.swift
//  TaskBase
//
//  Created by Jeytery on 19.05.2022.
//

import UIKit
import SnapKit

class IconInfoView: UIView {
    
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let lockImageView = UIImageView()
    private let iconView = UIImageView()
    
    private let colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureIconView(icon: UIImage())
        configureColorView(color: .red)
        configureLockImageView()
        configureStackView(title: "Untitled")
    }
    
    init(icon: UIImage, color: UIColor, title: String) {
        super.init(frame: .zero)
        configureIconView(icon: icon)
        configureColorView(color: color)
        configureLockImageView()
        configureStackView(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - internal funcions
private extension IconInfoView {
    func configureIconView(icon: UIImage) {
        colorView.addSubview(iconView)
        iconView.snp.makeConstraints() {
            $0.height.width.equalToSuperview().dividedBy(1.35)
            $0.center.equalToSuperview()
        }
        iconView.contentMode = .scaleAspectFit
        iconView.image = icon
        
        iconView.tintColor = .white
    }
    
    func configureColorView(color: UIColor) {
        addSubview(colorView)
        colorView.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.height.equalToSuperview().dividedBy(2)
            $0.width.equalTo(colorView.snp.height)
        }
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 10
    }
    
    func configureLockImageView() {
        addSubview(lockImageView)
        lockImageView.image = UIImage(systemName: "lock.fill")
        lockImageView.snp.makeConstraints() {
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(1.3)
        }
        
        lockImageView.tintColor = .systemGray2
        
        lockImageView.isHidden = true
        lockImageView.contentMode = .scaleAspectFit
    }
    
    func configureStackView(title: String) {
        addSubview(labelStackView)
        labelStackView.snp.makeConstraints() {
            $0.left.equalTo(iconView.snp.right).offset(15)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(lockImageView.snp.left).offset(-10)
        }
        
        labelStackView.axis = .vertical
    
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
        subtitleLabel.isHidden = true
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .systemBlue
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.text = title
    }
}

//MARK: - public interface
extension IconInfoView {
    func showSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = false
    }
    
    func hideSubtitle() {
        subtitleLabel.isHidden = true
    }
    
    func lock() {
        lockImageView.isHidden = false
    }
    
    func unlock() {
        lockImageView.isHidden = true
    }
    
    func configure(icon: UIImage, color: UIColor, title: String) {
        iconView.image = icon
        colorView.backgroundColor = color
        titleLabel.text = title
    }
}
