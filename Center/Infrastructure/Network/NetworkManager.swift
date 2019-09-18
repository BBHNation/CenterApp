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
    
    func get(url: String, complete: @escaping (NetworkErrorCode?, Data?)->Void) -> Void
    
    func post(url: String, parameters: [String:Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) -> Void
    
    func put(url: String, parameters: [String:Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) -> Void
}

class NetworkManagerImpl: NetworkManager {
    
    static let shared = NetworkManagerImpl()
    
    private let baseUrl = NetworkConfig.shared.baseUrl
    
    func post(url: String, parameters: [String: Any]? = nil, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        putOrPost(method: .post, url: url, parameters: parameters, complete: complete)
    }
    
    func put(url: String, parameters: [String : Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        putOrPost(method: .put, url: url, parameters: parameters, complete: complete)
    }

    func get(url: String, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        AF.request(NetworkConfig.shared.baseUrl + url).responseData { [weak self] response in
            self?.handleResponse(response, complete)
        }
    }

    
    private func putOrPost(method: Alamofire.HTTPMethod, url: String, parameters: [String: Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        AF.request(baseUrl + url,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: Alamofire.HTTPHeaders.init(["Content-type":"application/json"])
            )
            .responseData { [weak self]
                (response) in
                self?.handleResponse(response, complete)
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<Data>, _ complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        let statusCode = "\(response.response?.statusCode ?? 500)"
        if statusCode.hasPrefix("2"){
            complete(nil, response.data)
        } else {
            complete(NetworkErrorCode.init(statusCode: statusCode), response.data)
        }
    }
}
