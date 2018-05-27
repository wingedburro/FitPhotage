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

class ProfileViewController: UITabBarController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupNavBar()
        tabBarController?.tabBar.barTintColor = UIColor.green
        setupTabBar()
        
        setupLogoutButton()
    }
    
    // Gradient Color Assignment
    private func setupGradient() {
        let color1 = UIColor(red:1.00, green:0.32, blue:0.18, alpha:1.0).cgColor
        let color2 = UIColor(red: 0.94, green: 0.60, blue: 0.1, alpha: 1.0).cgColor
        let ground = profileBackground(frame: view.bounds, color1: color1, color2: color2)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }
    
    // Navigation Bar Assignment
    private func setupNavBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Profile"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    // Tab Bar Assignement
    private func setupTabBar() {
//        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
//        profileViewController.tabBarItem.image = UIImage(named: "BackButton")
//        profileViewController.tabBarItem.selectedImage = UIImage(named: "LivFit")
        
        let informationViewController = UINavigationController(rootViewController: InformationViewController())
        informationViewController.tabBarItem.image = UIImage(named: "LivFit")
        informationViewController.tabBarItem.selectedImage = UIImage(named: "BackButton")
        
        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        loginViewController.tabBarItem.image = UIImage(named: "LivFit")
        loginViewController.tabBarItem.selectedImage = UIImage(named: "BackButton")
        
        viewControllers = [loginViewController,informationViewController]
    }
    
    private func setupLogoutButton() {
        let logoutButton = UIButton(frame: CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 24, width: 200, height: 48))
        logoutButton.backgroundColor = UIColor.orange
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(googleLogoutHandler), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    @objc private func googleLogoutHandler() {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
