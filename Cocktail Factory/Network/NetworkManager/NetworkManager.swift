//
//  NetworkManager.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

class NetworkManager {

    private static var networkManger: NetworkManager?
    
    private init( ) { }
    
    public static func shared() -> NetworkManager {
        if networkManger == nil {
            networkManger = NetworkManager()
        }
        return networkManger!
    }
    
    func getRandomCocktail(result: @escaping (RandomCocktailResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.random.url, parameter: nil, responseType: RandomCocktailResponse.self, success: { (igredientResponse) in
            result(igredientResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    func filterAlcoholByType(type: String,
                             result: @escaping (CategoryFilterResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.filterByAlcohol(type).url, parameter: nil, responseType: CategoryFilterResponse.self, success: { (filterAlcoholResponse) in
            result(filterAlcoholResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    func getCategory(result: @escaping (CategoryResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.category.url, parameter: nil, responseType: CategoryResponse.self, success: { (categoryResponse) in
            result(categoryResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    func getCategoryByFilter(categoryName: String,
                             result: @escaping (CategoryFilterResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.categoryFilter(categoryName).url, parameter: nil, responseType: CategoryFilterResponse.self, success: { (categoryFilterResponse) in
            result(categoryFilterResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    func getGlass(result: @escaping (GlassResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.glass.url, parameter: nil, responseType: GlassResponse.self, success: { (glassREsponse) in
            result(glassREsponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }

    func getGlassByFilter(glassName: String,
                          result: @escaping (CategoryFilterResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.glassFilter(glassName).url, parameter: nil, responseType: CategoryFilterResponse.self, success: { (glassFilterResponse) in
            result(glassFilterResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    func getIngredient(idDrink: String,
                       result: @escaping (RandomCocktailResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.ingredients(idDrink).url, parameter: nil, responseType: RandomCocktailResponse.self, success: { (igredientResponse) in
            result(igredientResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
}
