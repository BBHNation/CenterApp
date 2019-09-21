//
//  WeekplanCell.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class WeekplanCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var weekNumLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusImage: UIImageView!
    
    private var model: WeekplanModel? {
        didSet {
            refreshLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setModel(_ model: WeekplanModel) {
        self.model = model
    }
    
    private func refreshLayout() {
        weekNumLabel.text = "第\(model?.weekNum ?? 0)周"
        
        if let summary = model?.summary {
            let scorePercent = CGFloat(summary.score ?? 0) / 10
            widthConstraint = widthConstraint.setMultiplier(multiplier: scorePercent)
            switch scorePercent {
            case (0...0.6):
                progressView.backgroundColor = UIColor.init(named: "Bad")
            case (0.6..<1):
                progressView.backgroundColor = UIColor.init(named: "Warning")
            case (1):
                progressView.backgroundColor = UIColor.init(named: "Main")
            default:
                progressView.backgroundColor = UIColor.init(named: "Main")
            }
            
            switch summary.result {
            case .none:
                statusImage.image = #imageLiteral(resourceName: "nothingTodo")
            case .some(.getAward):
                statusImage.image = #imageLiteral(resourceName: "gift")
            case .some(.getPunishment):
                statusImage.image = #imageLiteral(resourceName: "punishment")
            case .some(.nothingTodo):
                statusImage.image = #imageLiteral(resourceName: "nothingTodo")
            }
        } else {
            statusImage.image = #imageLiteral(resourceName: "nothingTodo")
            widthConstraint = widthConstraint.setMultiplier(multiplier: 0)
        }
    }
    
    private func initLayout() {
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.cornerRadius = 5
        
        progressView.layer.cornerRadius = 8
        progressView.layer.masksToBounds = true
    }
    
}
