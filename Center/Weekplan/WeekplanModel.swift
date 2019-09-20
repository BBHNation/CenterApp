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
    
    var summary: WeekSummaryModel?
    
    override var description: String {
        let desc = """
        \n{
        id: \(id ?? "nil"),
        weekNum: \(weekNum ?? 0),
        content: \(content ?? "nil"),
        award: \(award ?? "nil"),
        punishment: \(punishment ?? "nil")
        summary: \(summary?.description ?? "nil")
        }
        """
        return desc
    }
}

class WeekSummaryModel: NSObject, Codable {
    var id: String?
    
    var planId: String?
    
    var content: String?
    
    var score: Int?
    
    var result: Result?
    
    override var description: String {
        let desc = """
        【
            id: \(id ?? "nil"),
            planId: \(planId ?? "nil"),
            content: \(content ?? "nil"),
            score: \(score ?? 0)
            result: \(result.debugDescription)
        】
        """
        return desc
    }
    
    enum Result: String, Codable {
        case getAward = "GET_AWARD"
        case getPunishment = "GET_PUNISHMENT"
        case nothingTodo = "NOTHING_TODO"
    }
}
