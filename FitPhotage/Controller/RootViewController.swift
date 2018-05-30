//
//  RootViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/29/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var currentView: UIViewController
    
    init() {
        self.currentView = LoginViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(currentView)
        currentView.view.frame = view.bounds
        view.addSubview(currentView.view)
        currentView.didMove(toParentViewController: self)
    }
    
    func switchToMainView() {
        let mainViewController = CustomTabBarController()
        animateFadeTransition(newController: mainViewController)
    }
    
    func switchToLoginScreen() {
        let loginViewController = LoginViewController()
        animateDismissTransition(newController: loginViewController)
    }
    
    private func animateFadeTransition(newController: UIViewController, completion: (() -> Void)? = nil) {
        currentView.willMove(toParentViewController: nil)
        addChildViewController(newController)
        
        transition(from: currentView, to: newController, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.currentView.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
            self.currentView = newController
            completion?()
        }
    }
    
    private func animateDismissTransition(newController: UIViewController, completion: (() -> Void)? = nil) {
        currentView.willMove(toParentViewController: nil)
        addChildViewController(newController)
        transition(from: currentView, to: newController, duration: 0.3, options: [], animations: {
            newController.view.frame = self.view.bounds
        }) { completed in
            self.currentView.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
            self.currentView = newController
            completion?()
        }
    }

}
