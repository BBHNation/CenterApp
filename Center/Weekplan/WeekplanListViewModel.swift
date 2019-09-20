//
//  WeekplanListViewModel.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

protocol WeekplanListViewControllerDelegate {
    func refreshList()
    func errorNotice(_ message: String)
}

class WeekplanListViewModel {
    
    private var delegate: WeekplanListViewControllerDelegate
    private var networkManager: NetworkManager
    private let dispatchGroup = DispatchGroup()
    
    init(delegate: WeekplanListViewControllerDelegate) {
        self.delegate = delegate
        self.networkManager = NetworkManagerImpl.shared
    }
    
    var weekplanList: [WeekplanModel] = [WeekplanModel]() {
        didSet {
            delegate.refreshList()
        }
    }
    
    func fetchWeekplanList() {
        networkManager.get(url: "/weekplan/all") { [weak self] (errCode, data) in
            guard let `self` = self else { return }
            if errCode != nil {
                self.handleErrorCode(errCode!)
                return
            }
            guard let data = data else {
                self.delegate.errorNotice("啊哦，服务器数据为空！")
                return
            }
            self.handleWeekplanListResponseData(data)
        }
    }
    
    func fetchWeekSummaryWithWeekplan(weekplan: WeekplanModel) {
        dispatchGroup.enter()
        networkManager.get(url: "/weeksummary/plan/\(weekplan.id ?? "")") { [weak self] (errCode, data) in
            guard let `self` = self else { return }
            if errCode != nil {
                self.handleErrorCode(errCode!)
                self.dispatchGroup.leave()
                return
            }
            guard let data = data else {
                self.delegate.errorNotice("查询周总结失败！")
                self.dispatchGroup.leave()
                return
            }
            self.handleWeekSummaryResponseData(weekplan, data)
            self.dispatchGroup.leave()
        }
    }
    
    private func handleErrorCode(_ errCode: NetworkErrorCode) {
        switch errCode {
        case .internalServerError:
            delegate.errorNotice("啊哦，服务器内部错误！")
        case .notFoundError:
            delegate.errorNotice("啊哦，资源未找到！")
        case .duplicateError:
            delegate.errorNotice("啊哦，出现重复数据了！")
        }
    }
    
    private func handleWeekSummaryResponseData(_ weekplan: WeekplanModel, _ data: Data) {
        guard let summaryModel: WeekSummaryModel = JSONConvertor.dataToObject(data: data) else {
            self.delegate.errorNotice("啊哦，数据格式有误，无法转换！")
            return
        }
        weekplan.summary = summaryModel
    }
    
    private func handleWeekplanListResponseData(_ data: Data) {
        guard let list: [WeekplanModel] = JSONConvertor.dataToObject(data: data) else {
            self.delegate.errorNotice("啊哦，数据格式有误，无法转换！")
            return
        }
        for weekplan in list {
            fetchWeekSummaryWithWeekplan(weekplan: weekplan)
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.weekplanList = list
        }
    }
    
}
