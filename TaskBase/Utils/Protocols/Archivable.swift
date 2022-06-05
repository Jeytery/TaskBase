//
//  Archivable.swift
//  TaskBase
//
//  Created by Jeytery on 05.06.2022.
//

import Foundation

protocol Archivable: Codable {
    func archive() -> Data
    static func unarchive(data: Data) -> Self
}

extension Archivable {
    func archive() -> Data {
        let json = try! JSONEncoder().encode(self)
        return Data(json)
    }
    
    static func unarchive(data: Data) -> Self {
        return try! JSONDecoder().decode(Self.self, from: data)
    }
}
