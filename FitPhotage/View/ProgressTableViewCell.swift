//
//  ProgressTableViewCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, text: String?, textHighlightColor: UIColor?, disclosure: Bool?, progress: UIImage?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = text
        self.backgroundColor = UIColor.black
        self.textLabel?.textColor = UIColor.white
        self.textLabel?.highlightedTextColor = textHighlightColor
        let customSelectColor = UIView()
        customSelectColor.backgroundColor = UIColor.darkGray
        self.selectedBackgroundView = customSelectColor
        if disclosure == true {
            self.accessoryType = .disclosureIndicator
        }
        self.imageView?.image = progress
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
