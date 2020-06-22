//
//  Drinks.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

struct Drink : Codable, Hashable, Identifiable {
    
    let id = UUID()
    let strCategory : String?
    
    enum CodingKeys: String, CodingKey {
        case strCategory = "strCategory"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
    }
    
    static func == (lhs: Drink, rhs: Drink) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
