//
//  CakeItem.swift
//  Cake List
//
//  Created by Steven Hendrie on 18/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import Foundation

struct CakeItem: Codable {

    let title: String
    let description: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case imageURL = "image"
    }
    
    init(title: String, description: String, imageURL: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
