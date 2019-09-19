//
//  WeekplanViewController.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class WeekplanListVC: UITableViewController {
    private var viewModel: WeekplanListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeekplanListViewModel(delegate: self)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.refreshTable()
        }
    }
    
    func refreshTable() {
        viewModel?.fetchWeekplanList()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension WeekplanListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "weekplan", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
}

extension WeekplanListVC: WeekplanListViewControllerDelegate {
    
    func refreshList() {
        print("refresh: ")
        print(viewModel?.weekplanList ?? "list is null")
    }
    
    func errorNotice(_ message: String) {
        print("error: \(message)")
    }
    
    
}
