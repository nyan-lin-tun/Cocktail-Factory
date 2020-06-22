//
//  GenericNetwork.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 21/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

class GenericNetwork {
    
    private static var genericNetworkManager: GenericNetwork?
    
    private init( ) { }
    
    public static func shared() -> GenericNetwork {
        if genericNetworkManager == nil {
            genericNetworkManager = GenericNetwork()
        }
        return genericNetworkManager!
    }
    
    func getRequest<ResponseType: Codable>(apiRoute url: URL,
                               parameter: [String : Any]?,
                               responseType: ResponseType.Type,
                               success: @escaping(ResponseType) -> Void,
                               failure: @escaping(Error) -> Void) {
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    success(responseObject)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        task.resume()
    }
    
    func postRequest<RequestType: Encodable, ResponseType: Codable>(apiRoute url: URL,
                            parameter: RequestType,
                            responseType: ResponseType.Type,
                            success: @escaping(ResponseType) -> Void,
                            failure: @escaping(Error) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(parameter)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    success(responseObject)
                }
            } catch {
                failure(error)
            }
        }
        task.resume()
    }
    
    func getPhotoData(imageUrl: String,
                            completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: imageUrl)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }
        task.resume()
    }
    
}
