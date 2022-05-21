//
//  NavigationButtonable.swift
//  TaskBase
//
//  Created by Jeytery on 21.05.2022.
//

import UIKit

fileprivate extension UIViewController {
    @objc func leftNavigationButtonAction() {
        guard let self = self as? LeftNavigationButtonable else {
            return
        }
        self.leftNavigationButtonDidTap()
    }
    
    @objc func rightNavigationButtonAction() {
        guard let self = self as? RightNavigationButtonable else {
            return
        }
        self.rightNavigationButtonDidTap()
    }
}

protocol LeftNavigationButtonable {
    
    func configureLeftNavigationButton()
    func leftNavigationButtonDidTap()
    
    func leftNavigationButtonImage() -> UIImage?
    func leftNavigationButtonTitle() -> String?
    func leftNavigationButtonSystemItem() ->  UIBarButtonItem.SystemItem?
    
    func leftNavigationButtonStyle() -> UIBarButtonItem.Style
    func leftNavigationButtonTintColor() -> UIColor
}

protocol RightNavigationButtonable {
    func configureRightNavigationButton()
    func rightNavigationButtonDidTap()
    
    func rightNavigationButtonImage() -> UIImage?
    func rightNavigationButtonTitle() -> String?
    func rightNavigationButtonSystemItem() ->  UIBarButtonItem.SystemItem?
    
    func rightNavigationButtonStyle() -> UIBarButtonItem.Style
    func rightNavigationButtonTintColor() -> UIColor
}

extension LeftNavigationButtonable where Self: UIViewController {
    func configureLeftNavigationButton() {
        var tabButton: UIBarButtonItem!
        
        if let image = leftNavigationButtonImage() {
            tabButton = UIBarButtonItem(
                image: image,
                style: leftNavigationButtonStyle(),
                target: self,
                action: #selector(leftNavigationButtonAction)
            )
        }
        else if let title = leftNavigationButtonTitle() {
            tabButton = UIBarButtonItem(
                title: title,
                style: leftNavigationButtonStyle(),
                target: self,
                action: #selector(leftNavigationButtonAction)
            )
        }
        else if let systemItem = leftNavigationButtonSystemItem() {
            tabButton =  UIBarButtonItem(
                barButtonSystemItem: systemItem,
                target: self,
                action: #selector(leftNavigationButtonAction)
            )
        }
        
        tabButton.tintColor = leftNavigationButtonTintColor()
        
        navigationItem.leftBarButtonItem = tabButton
    }
    
    func leftNavigationButtonStyle() -> UIBarButtonItem.Style {
        return .plain
    }
    
    func leftNavigationButtonTintColor() -> UIColor {
        return .systemBlue
    }
    
    func leftNavigationButtonImage() -> UIImage? {
        return nil     
    }
    
    func leftNavigationButtonTitle() -> String? {
        return nil
    }
    
    func leftNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return nil
    }
}

extension RightNavigationButtonable where Self: UIViewController {
    func configureRightNavigationButton() {
        var tabButton: UIBarButtonItem!
        
        if let image = rightNavigationButtonImage() {
            tabButton = UIBarButtonItem(
                image: image,
                style: rightNavigationButtonStyle(),
                target: self,
                action: #selector(rightNavigationButtonAction)
            )
        }
        else if let title = rightNavigationButtonTitle() {
            tabButton = UIBarButtonItem(
                title: title,
                style: rightNavigationButtonStyle(),
                target: self,
                action: #selector(rightNavigationButtonAction)
            )
        }
        else if let systemItem = rightNavigationButtonSystemItem() {
            tabButton = UIBarButtonItem(
                barButtonSystemItem: systemItem,
                target: self,
                action: #selector(rightNavigationButtonAction)
            )
        }
        
        tabButton.tintColor = rightNavigationButtonTintColor()
        
        navigationItem.rightBarButtonItem = tabButton
    }
    
    func rightNavigationButtonStyle() -> UIBarButtonItem.Style {
        return .plain
    }
    
    func rightNavigationButtonTintColor() -> UIColor {
        return .systemBlue
    }
    
    func rightNavigationButtonImage() -> UIImage? {
        return nil
    }
    
    func rightNavigationButtonTitle() -> String? {
        return nil
    }
    func rightNavigationButtonSystemItem() -> UIBarButtonItem.SystemItem? {
        return nil
    }
}
