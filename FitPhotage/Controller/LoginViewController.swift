//
//  LoginViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupGoogleLogin()
    }
    
    private func setupGradient() {
        // Gradient Color Assignment
        let color1 = UIColor(red:1.00, green:0.32, blue:0.18, alpha:1.0).cgColor
        let color2 = UIColor(red: 0.94, green: 0.60, blue: 0.1, alpha: 1.0).cgColor
        let ground = profileBackground(frame: view.bounds, color1: color1, color2: color2)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }
    
    private func setupGoogleLogin() {
        GIDSignIn.sharedInstance().uiDelegate = self
        let googleSignInButton = GIDSignInButton()
        
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.style = .wide
        
        view.addSubview(googleSignInButton)
        view.addConstraintsWithFormat(format: "H:|-\(view.frame.width/2 - 100)-[v0(200)]", views: googleSignInButton)
        view.addConstraintsWithFormat(format: "V:|-\(view.frame.height/2 - 24)-[v0]", views: googleSignInButton)
    }

}

