//
//  NetworkManagerProtocol.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func getCategory(result: @escaping (CategoryResponse?, Error?) -> Void)
    
    func getCategoryByFilter(categoryName: String,
                             result: @escaping (CategoryFilterResponse?, Error?) -> Void)
    
    func getGlass(result: @escaping (GlassResponse?, Error?) -> Void)
    
    func getGlassByFilter(glassName: String,
                          result: @escaping (CategoryFilterResponse?, Error?) -> Void)
    
    func getIngredient(idDrink: String,
                       result: @escaping (RandomCocktailResponse?, Error?) -> Void)
    
}
