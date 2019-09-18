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
    init(statusCode: String) {
        self = .internalServerError
        if statusCode == "404" {
            self = .notFoundError
        }
    }
}
