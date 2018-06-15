//
//  ProfileTableViewCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, text: String?, textHighlightColor: UIColor?, disclosure: Bool) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = text
        self.backgroundColor = UIColor.white
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.highlightedTextColor = textHighlightColor
        let customSelectColor = UIView()
        customSelectColor.backgroundColor = UIColor.CustomColors.whiteSmoke
        self.selectedBackgroundView = customSelectColor
        if disclosure == true {
            self.accessoryType = .disclosureIndicator
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
