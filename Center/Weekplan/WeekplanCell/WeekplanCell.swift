//
//  WeekplanCell.swift
//  Center
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import UIKit

class WeekplanCell: UITableViewCell {
    private var model: WeekplanModel? {
        didSet {
            refreshLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setModel(_ model: WeekplanModel) {
        self.model = model
    }
    
    func refreshLayout() {
        
    }

}
