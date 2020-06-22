//
//  CategoryResponse.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

struct CategoryResponse : Codable {
    
    let drinks : [Drink]?
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        drinks = try values.decodeIfPresent([Drink].self, forKey: .drinks)
    }
    
}
