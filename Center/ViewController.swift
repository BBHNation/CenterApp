//
//  ViewController.swift
//  Center
//
//  Created by hancock on 2019/9/17.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManagerImpl.shared
        getAllWeekPlan()
    }
    
    private func getAllWeekPlan() {
        networkManager?.get(url: "/weekplan/all", complete: { (err, data) in
            if err == nil && data != nil {
                let arr: [Weekplan]? = JSONConvertor.dataToObject(data: data!)
                print(arr ?? "null")
            } else {
                print("falure")
            }
        })
    }
    
    
    private class Weekplan: NSObject, Codable {
        var id: String?
        
        var weekNum: Int?
        
        var content: String?
        
        var award: String?
        
        var punishment: String?
        
        override var description: String {
            return "id: \(id ?? "null"), weekNum: \(weekNum ?? 0), content: \(content ?? "null"), award: \(award ?? "null"), punishment: \(punishment ?? "null")"
        }
    }
    
    private func createWeekPlan() {
        let weekplan = Weekplan()
        weekplan.id = "123"
        weekplan.weekNum = 40
        weekplan.content = "123"
        weekplan.award = "123"
        weekplan.punishment = "123"
        
        let data = try? JSONEncoder().encode(weekplan)
        if data != nil {
//            let dic = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init()) as? [String: Any]
            let dic = JSONConvertor.objectToDic(object: weekplan)
            if dic != nil {
               networkManager?.post(url: "/weekplan/create", parameters: dic, complete: { (errorCode, data) in
                    if errorCode == nil {
                        let id: String? = JSONConvertor.dataToObject(data: data!)
                        print("id is \(id ?? "123")")
                    } else {
                        switch errorCode! {
                        case .internalServerError:
                            print("server error")
                        case .notFoundError:
                            print("not found")
                        default:
                            print("falure")
                        }
                    }
                })
            }
        } else {
            print("data is null")
        }

    }

}

