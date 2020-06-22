//
//  GenericNetworkProtocol.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 21/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation

protocol GenericNetworkProtocol {
    
    func getRequest<ResponseType: Codable>(apiRoute url: URL,
                                           parameter: [String : Any]?,
                                           responseType: ResponseType.Type,
                                           success: @escaping(ResponseType) -> Void,
                                           failure: @escaping(Error) -> Void)
    
    func postRequest<RequestType: Encodable, ResponseType: Codable>(apiRoute url: URL,
                                                                    parameter: RequestType,
                                                                    responseType: ResponseType.Type,
                                                                    success: @escaping(ResponseType) -> Void,
                                                                    failure: @escaping(Error) -> Void)
    
}
