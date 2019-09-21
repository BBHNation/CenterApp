//
//  WeekplanViewController.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit
import MJRefresh

class WeekplanListVC: UIViewController {
    private var viewModel: WeekplanListViewModel?
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "WeekplanCell", bundle: Bundle.main), forCellReuseIdentifier: "weekplan")
        viewModel = WeekplanListViewModel(delegate: self)
        tableView.refreshControl = UIRefreshControl.init()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    @objc func refreshTable() {
        viewModel?.fetchWeekplanList()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension WeekplanListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.weekplanList.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekplan", for: indexPath) as! WeekplanCell
        if let model = viewModel?.weekplanList[indexPath.row] {
            cell.setModel(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0,y: 0,width: 0,height: 22))
    }
}

extension WeekplanListVC: WeekplanListViewControllerDelegate {
    
    func refreshList() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func errorNotice(_ message: String) {
        print("error: \(message)")
    }
    
    
}
