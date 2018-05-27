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
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        setupGoogleLogin()
    }
    
    private func setupGoogleLogin() {
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.addTarget(self, action: #selector(googleLoginIn), for: .touchUpInside)
        view.addSubview(googleSignInButton)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: googleSignInButton)
        view.addConstraintsWithFormat(format: "V:|-150-[v0(50)]-150-|", views: googleSignInButton)
    }
    
    @objc private func googleLoginIn() {
        GIDSignIn.sharedInstance().signIn()
    }


}

