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
    
    
}
