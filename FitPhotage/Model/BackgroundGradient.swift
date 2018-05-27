//
//  BackgroundGradient.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class profileBackground: UIView {
    
    // Delaration of Gradient Layer
    let gradLayer = CAGradientLayer()
    
    init(frame: CGRect, color1: CGColor, color2: CGColor) {
        super.init(frame: frame)
        
        // Initialization of Gradient Layer
        layer.addSublayer(gradLayer)
        gradLayer.frame = bounds
        gradLayer.colors = [color1, color2]
        
        // Optional Animation
        /*
         // Fade in Animation on Center Text
         gradLayer.opacity = 0
         let animation = CABasicAnimation(keyPath: "opacity")
         animation.fromValue = 0
         animation.toValue = 1
         animation.duration = 2
         gradLayer.add(animation, forKey: nil)
         gradLayer.opacity = 1
         */
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

