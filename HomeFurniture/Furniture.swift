//
//  Furniture.swift
//  HomeFurniture
//
//  Created by Berlin Thomas on 2024-03-21.
//

import Foundation

class Furniture: Codable {
    let name: String
    let description: String
    var imageData: Data?
    
    init(name: String, description: String, imageData: Data? = nil) {
        self.name = name
        self.description = description
        self.imageData = imageData
    }
}
