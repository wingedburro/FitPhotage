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
        setupLogoutButton()
        loadProfileInfo()
        setupNavbar()
        
    }
    
    // Gradient Color Assignment
    private func setupGradient() {
        let color1 = UIColor(red:1.00, green:0.32, blue:0.18, alpha:1.0).cgColor
        let color2 = UIColor(red: 0.94, green: 0.60, blue: 0.1, alpha: 1.0).cgColor
        let ground = profileBackground(frame: view.bounds, color1: color1, color2: color2)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }
    
    private func setupLogoutButton() {
        let logoutButton = UIButton(frame: CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 24, width: 200, height: 48))
        logoutButton.backgroundColor = UIColor.orange
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(googleLogoutHandler), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    private func setupNavbar() {
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.black
        
        view.addSubview(statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "V:|[v0(20)]|", views: statusBarBackgroundView)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 50))
        navBar.backgroundColor = UIColor.black
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = textAttributes
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Profile"
        navBar.items = [navigationItem]
        view.addSubview(navBar)
    }
    
    @objc private func googleLogoutHandler() {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadProfileInfo() {
        let profileImageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        profileImageView.backgroundColor = UIColor.blue
        view.addSubview(profileImageView)
        view.addConstraintsWithFormat(format: "H:|-20-[v0(150)]", views: profileImageView)
        view.addConstraintsWithFormat(format: "V:|-90-[v0(150)]", views: profileImageView)
    }
    
}
