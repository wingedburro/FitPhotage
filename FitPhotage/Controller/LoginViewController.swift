//
//  LoginViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, FUIAuthDelegate {
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupLogin()
        
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
    }
    
    private func setupGradient() {
        // Gradient Color Assignment
        let color1 = UIColor(red:1.00, green:0.32, blue:0.18, alpha:1.0).cgColor
        let color2 = UIColor(red: 0.94, green: 0.60, blue: 0.1, alpha: 1.0).cgColor
        let ground = profileBackground(frame: view.bounds, color1: color1, color2: color2)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }
    
    @objc private func emailLoginAction() {
        let authViewController = authUI?.authViewController();
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    private func setupLogin() {
        GIDSignIn.sharedInstance().uiDelegate = self
        let googleSignInButton = GIDSignInButton()
        let emailSignInButton = ButtonWithImage()
        
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.style = .wide
        
        emailSignInButton.translatesAutoresizingMaskIntoConstraints = false
        emailSignInButton.backgroundColor = UIColor.CustomColors.lead
        emailSignInButton.layer.cornerRadius = 2
        emailSignInButton.setTitleColor(UIColor.white, for: .normal)
        emailSignInButton.setImage(UIImage(named: "email_icon"), for: .normal)
        emailSignInButton.setTitle("Sign up with Email",for: .normal)
        emailSignInButton.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(fontAttributes: [:]), size: 14)
        emailSignInButton.addTarget(self, action: #selector(emailLoginAction), for: .touchUpInside)
        
        view.addSubview(googleSignInButton)
        view.addSubview(emailSignInButton)
        view.addConstraintsWithFormat(format: "H:|-\(view.frame.width/2 - 100)-[v0(200)]", views: googleSignInButton)
        view.addConstraintsWithFormat(format: "H:|-\(view.frame.width/2 - 96)-[v0(192)]", views: emailSignInButton)
        view.addConstraintsWithFormat(format: "V:|-\(view.frame.height/2 - 40)-[v0]-16-[v1(\(googleSignInButton.frame.height - 9))]", views: googleSignInButton, emailSignInButton)
    }

}

