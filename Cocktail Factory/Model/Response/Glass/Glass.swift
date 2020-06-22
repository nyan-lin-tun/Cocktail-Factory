//
//  Glass.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

struct Glass : Codable, Hashable, Identifiable {
    
    let id = UUID()
    let strGlass : String?
    
    enum CodingKeys: String, CodingKey {
        case strGlass = "strGlass"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strGlass = try values.decodeIfPresent(String.self, forKey: .strGlass)
    }
    
    static func == (lhs: Glass, rhs: Glass) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
