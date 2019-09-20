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
    
    func refreshLayout() {
        
    }
    
    func initLayout() {
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.cornerRadius = 5
    }

}
