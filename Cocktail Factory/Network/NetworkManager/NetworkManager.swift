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
    
    func getCategory(result: @escaping (CategoryResponse?, Error?) -> Void) {
        GenericNetwork.shared().getRequest(apiRoute: APIRoutes.Endpoints.category.url, parameter: nil, responseType: CategoryResponse.self, success: { (categoryResponse) in
            result(categoryResponse, nil)
        }) { (error) in
            result(nil, error)
        }
    }
    
    
}
