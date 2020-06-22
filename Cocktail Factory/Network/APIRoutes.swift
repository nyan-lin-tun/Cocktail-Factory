//
//  APIRoutes.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

class APIRoutes {
    
    enum Endpoints {
        
        case category
        case categoryFilter(String)
        
        case glass
        case glassFilter(String)
    
        var stringValue: String {
            switch self {
            case .category:
                return baseUrl() + "list.php?c=list"
            case .categoryFilter(let category):
                return baseUrl() + "filter.php?c=\(category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            
            case .glass:
                return baseUrl() + "list.php?g=list"
            case .glassFilter(let glass):
                return baseUrl() + "filter.php?g=\(glass.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            }
        }
    
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}


func baseUrl() -> String {
    return "https://www.thecocktaildb.com/api/json/v1/1/"
}
