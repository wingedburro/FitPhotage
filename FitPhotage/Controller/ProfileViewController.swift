//
//  ProfiileViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        
    }
    
    private func setupGradient() {
        // Gradient Size Assignment
        let xcoord = self.view.frame.size.width
        let ycoord = self.view.frame.size.height
        
        // Gradient Color Assignment
        let color1 = UIColor(red:1.00, green:0.32, blue:0.18, alpha:1.0).cgColor
        let color2 = UIColor(red: 0.94, green: 0.60, blue: 0.1, alpha: 1.0).cgColor
        
        // Gradient Placement
        let back = CGRect(x: 0, y: 0, width: xcoord, height: ycoord)
        let ground = profileBackground(frame: back, color1: color1, color2: color2)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }
    
    
}
