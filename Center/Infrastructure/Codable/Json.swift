//
//  Json.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import Foundation

private protocol JsonConvertor {
    
    func toDic<T>(_ object: T?) -> [String: Any]? where T: Codable
    
    func toObject<T: Codable>(_ type: T, _ data: Data?) -> T?
}

private extension JsonConvertor {
    
    func toDic<T: Codable>(_ object: T?) -> [String: Any]? {
        guard let object = object else { return nil }
        do {
            let data = try JSONEncoder().encode(object)
            let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dic
        } catch let err as NSError {
            debugPrint(err)
            return nil
        }
    }
    
    func toObject<T: Codable>(_ type: T, _ data: Data?) -> T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func toObject<T: Codable>(_ data: Data?) -> T? {
        guard let data = data else { return nil }
        if T.self == String.self {
            return String.init(data: data, encoding: String.Encoding.utf8) as? T
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    

}

class JSONConvertor: JsonConvertor {
    static func objectToDic<T: Codable>(object: T?) -> [String: Any]? {
        return JSONConvertor().toDic(object)
    }
    
    static func dataToObject<T: Codable>(data: Data?) -> T? {
        return JSONConvertor().toObject(data)
    }
}
