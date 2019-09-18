//
//  NetworkManager.swift
//  Center
//
//  Created by hancock on 2019/9/17.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManager {
    
    var baseUrl: String { get }
    
    func get(url: String, complete: @escaping (Bool, Data?)->Void) -> Void
    
}

class NetworkManagerImpl: NetworkManager {
    static let shared = NetworkManagerImpl()
    
    let baseUrl: String = "http://178.128.118.70"
    
    func get(url: String, complete: @escaping (Bool, Data?) -> Void) {
        AF.request(baseUrl + url).response { response in
            complete("\(response.response?.statusCode ?? 500)".hasPrefix("2"), response.data)
        }
    }
}
