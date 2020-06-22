//
//  CategoryFilterDrinks.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

struct CategoryFilterDrink : Codable, Hashable, Identifiable {
    
    let id = UUID()
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
    
    enum CodingKeys: String, CodingKey {
        case strDrink = "strDrink"
        case strDrinkThumb = "strDrinkThumb"
        case idDrink = "idDrink"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strDrink = try values.decodeIfPresent(String.self, forKey: .strDrink)
        strDrinkThumb = try values.decodeIfPresent(String.self, forKey: .strDrinkThumb)
        idDrink = try values.decodeIfPresent(String.self, forKey: .idDrink)
    }
    
    static func == (lhs: CategoryFilterDrink, rhs: CategoryFilterDrink) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
