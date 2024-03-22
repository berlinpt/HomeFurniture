//
//  Room.swift
//  HomeFurniture
//
//  Created by Berlin Thomas on 2024-03-21.
//

import Foundation

class Room: Codable {
    let name: String
    let furniture: [Furniture]
    
    init(name: String, furniture: [Furniture]) {
        self.name = name
        self.furniture = furniture
    }
}
