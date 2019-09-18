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
        networkManager = NetworkManagerImpl.shared as NetworkManager
        getAllWeekPlanList()
    }
    
    private func testNetworkManager() {
        networkManager?.get(url: "/tech/health", complete: { (success, data) in
            var result: String = ""
            if success {
                if data == nil {
                    result = "success but data is nil"
                } else {
                    result = "success and " + (String.init(data: data!, encoding: String.Encoding.utf8) ?? "data can't convert to string")
                }
            } else {
                result = "falure"
            }
            print(result)
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
    
    private func getAllWeekPlanList() {
        networkManager?.get(url: "/weekplan/b0072742-5eb0-4d60-b6f3-083dd82ebb63", complete: { (success, data) in
            if success && data != nil {
                do {
                    let weekplan = try JSONDecoder().decode([Weekplan].self, from: data!)
                    print(weekplan)
                } catch let error as NSError {
                    let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: [])
                    print(error.localizedDescription + " json data is: " + jsonObject.debugDescription)
                }
            } else {
                print("falure")
            }
        })
    }

}

