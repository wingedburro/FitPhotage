//
//  ButtonWithImage.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/20/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: bounds.width - 48)
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowOpacity = 0.3
            self.layer.shadowRadius = 0.0
            self.layer.masksToBounds = false
//            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 0)
        }
    }

}
