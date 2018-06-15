//
//  SplashViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/15/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import GoogleSignIn

class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LivFit")
        imageView.frame.size.height = 220
        imageView.frame.size.width = 220
        imageView.center = view.center
        
        view.backgroundColor = UIColor.black
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
            GIDSignIn.sharedInstance().signInSilently()
        }
    }
    
}
