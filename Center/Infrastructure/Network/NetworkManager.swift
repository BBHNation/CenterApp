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
    
    static var shared: NetworkManager { get }
    
    func get(url: String, complete: @escaping (NetworkErrorCode?, Data?)->Void) -> Void
    
    func post(url: String, parameters: [String:Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) -> Void
    
    func put(url: String, parameters: [String:Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) -> Void
}

extension NetworkManager {
    
    private var baseUrl: String {
        return NetworkConfig.shared.baseUrl
    }
    
    func post(url: String, parameters: [String: Any]? = nil, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        putOrPost(method: .post, url: url, parameters: parameters, complete: complete)
    }
    
    func put(url: String, parameters: [String : Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        putOrPost(method: .put, url: url, parameters: parameters, complete: complete)
    }
    
    func get(url: String, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        AF.request(baseUrl + url).responseData { response in
            self.handleResponse(response, complete)
        }
    }

    private func putOrPost(method: Alamofire.HTTPMethod, url: String, parameters: [String: Any]?, complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        AF.request(baseUrl + url,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: Alamofire.HTTPHeaders.init(["Content-type":"application/json"])
            )
            .responseData { (response) in
                self.handleResponse(response, complete)
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<Data>, _ complete: @escaping (NetworkErrorCode?, Data?) -> Void) {
        complete(NetworkErrorCode(statusCode: response.response?.statusCode), response.data)
    }
}

class NetworkManagerImpl: NetworkManager {
    static var shared: NetworkManager = NetworkManagerImpl()
}
