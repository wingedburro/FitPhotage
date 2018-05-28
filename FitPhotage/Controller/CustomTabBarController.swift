//
//  CustomTabBarController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/27/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        //Profile Tab
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.image = UIImage(named: "profile_icon")
        profileViewController.title = "Profile"
        
        //Workouts Tab
        let layout = UICollectionViewFlowLayout()
        let workoutsViewController = UINavigationController(rootViewController: WorkoutsViewController(collectionViewLayout: layout))
        workoutsViewController.tabBarItem.image = UIImage(named: "workouts_icon")
        workoutsViewController.title = "Workouts"
        
        //Documents Tab
        let documentsViewController = UIViewController()
        documentsViewController.tabBarItem.image = UIImage(named: "documents_icon")
        documentsViewController.title = "Documents"
        
        // Tasks Tab
        let tasksViewController = UIViewController()
        tasksViewController.tabBarItem.image = UIImage(named: "tasks_icon")
        tasksViewController.title = "Tasks"
        
        viewControllers = [profileViewController, workoutsViewController, documentsViewController, tasksViewController]
        
        tabBar.isTranslucent = false
    }
    

}
