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
        //Gradient size assignment
        let xcoord = self.view.frame.size.width
        let ycoord = self.view.frame.size.height
        
        let back = CGRect(x: 0, y: 0, width: xcoord, height: ycoord)
        let ground = profileBackground(frame: back)
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

    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }

}

