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
        GIDSignIn.sharedInstance().signIn()
        
        let googleSignInButton = GIDSignInButton()
        
        view.addSubview(googleSignInButton)
        
        //Gradient size assignment
        let xcoord = self.view.frame.size.width
        let ycoord = self.view.frame.size.height
        
        let back = CGRect(x: 0, y: 0, width: xcoord, height: ycoord)
        let ground = profileBackground(frame: back)
        view.insertSubview(ground, at: 0)
        ground.layer.shouldRasterize = false
    }


}

