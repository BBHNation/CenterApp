//
//  WeekplanNavController.swift
//  Center
//
//  Created by hancock on 2019/9/21.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class WeekplanNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        if #available(iOS 13.0, *) {
            let navbar = self.navigationBar
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.init(named: "Main")
            navbar.standardAppearance = navBarAppearance
            navbar.scrollEdgeAppearance = navBarAppearance
            navbar.prefersLargeTitles = true
            navbar.barStyle = .black
            navbar.shadowImage = #imageLiteral(resourceName: "shadow")
        }
    }

}
