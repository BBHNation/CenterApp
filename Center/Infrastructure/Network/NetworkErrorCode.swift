//
//  NetworkErrorCode.swift
//  Center
//
//  Created by hancock on 2019/9/18.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import Foundation

enum NetworkErrorCode {
    case internalServerError
    case notFoundError
    case duplicateError
    
    init?(statusCode: String?) {
        if statusCode?.hasPrefix("2") ?? false {
            return nil
        } else if statusCode == "404" {
            self = .notFoundError
        } else {
            self = .internalServerError
        }
    }
    
    init?(statusCode: Int?) {
        let code = NetworkErrorCode.init(statusCode: "\(statusCode ?? 500)")
        if code == nil {
            return nil
        } else {
            self = code!
        }
    }
}
