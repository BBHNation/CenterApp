//
//  WeekplanModel.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class WeekplanModel: NSObject, Codable {
    var id: String?
    
    var weekNum: Int?
    
    var content: String?
    
    var award: String?
    
    var punishment: String?
    
    override var description: String {
        let desc = """
        \n{
        id: \(id ?? "nil"),
        weekNum: \(weekNum ?? 0),
        content: \(content ?? "nil"),
        award: \(award ?? "nil"),
        punishment: \(punishment ?? "nil")
        }
        """
        return desc
    }
}
