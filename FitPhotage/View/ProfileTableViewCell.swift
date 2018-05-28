//
//  ProfileTableViewCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, text: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = text
        self.backgroundColor = UIColor.black
        self.textLabel?.textColor = UIColor.white
        let customSelectColor = UIView()
        customSelectColor.backgroundColor = UIColor.orange
        self.selectedBackgroundView = customSelectColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
