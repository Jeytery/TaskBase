//
//  ViewableTableViewCell.swift
//  TaskBase
//
//  Created by Jeytery on 29.05.2022.
//

import UIKit

class ViewableTableViewCell<T: UIView>: UITableViewCell {
    
    private(set) var baseView: T!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = T()
        self.baseView = view
        setView(view)
    }
    
    init(
        view: T,
        edges: UIEdgeInsets,
        style: UITableViewCell.CellStyle = .default,
        reuseIdentifier: String? = nil
    ) {
        self.baseView = view
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView(baseView, edges: edges)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(
        _ _view: T,
        edges: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        contentView.addSubview(baseView)
    
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: edges.top).isActive = true
        _view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -edges.bottom).isActive = true
        _view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edges.left).isActive = true
        _view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edges.right).isActive = true
    }
}

