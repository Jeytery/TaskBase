//
//  SettingsViewController.swift
//  TaskBase
//
//  Created by Jeytery on 10.05.2022.
//

import UIKit
import SPDiffable
import SafeSFSymbols
import SPSettingsIcons

class SettingsViewController: SPDiffableTableController {
   
    init() {
        super.init(style: .insetGrouped)
        
        tabBarItem = .init(
            title: nil,
            image: UIImage(.gear),
            tag: 0
        )
        
        title = "Settings"
        
        configureDiffable(
            sections: content,
            cellProviders: SPDiffableTableDataSource.CellProvider.default
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SettingsViewController {
     var content: [SPDiffableSection] {
         let rows: [SPDiffableTableRow] = [
             .init(
                 text: "Send message to us",
                 detail: nil,
                 icon: UIImage.generateSettingsIcon("envelope.fill", backgroundColor: .systemBlue),
                 accessoryType: .disclosureIndicator,
                 selectionStyle: .default,
                 action: nil
             )
         ]
         
         return [
             .init(
                 id: "1",
                 header: SPDiffableTextHeaderFooter(text: "Social"),
                 footer: nil,
                 items: rows
             )
         ]
     }
}
