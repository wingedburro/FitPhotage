//
//  AppDelegate.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() //Enable Firebase
        
        // Enable Google Sign In
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Light status bar
        application.statusBarStyle = .lightContent
        
        setupTabBar()
        
        return true
    }
    
    func setupTabBar() {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = "Words"
        navController.tabBarItem.image = UIImage(named: "BackButton")
    }
  
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Google Sign In
        return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
    
    // For Google Sign In to work on ios 8 and earlier
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    // Handle Google sign in process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                return
            }
            
            if user != nil {
                let databaseRef = Database.database().reference()
                let uid = Auth.auth().currentUser?.uid
                let userReference = databaseRef.child("Users").child(uid!)
                userReference.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild("Name") {
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            Main.appUser.name = dictionary["Name"] as? String
                            Main.appUser.email = dictionary["Email"] as? String
                            self.segueToMain()
                        }
                    } else {
                        Main.appUser.name = user.profile.name
                        Main.appUser.email = user.profile.email
                        let values = ["Name": Main.appUser.name, "Email": Main.appUser.email]
                        userReference.updateChildValues(values as Any as! [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                            if error != nil {
                                print("Error signing in with Google")
                            }
                        })
                        self.segueToMain()
                    }
                })
            }
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
    // End Google sign in process

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func segueToMain() {
        // Access the storyboard and fetch an instance of the view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController")
        
        // Push that view controller onto the navigation stack
        let rootViewController = self.window!.rootViewController!
        rootViewController.present(profileViewController, animated: true, completion: nil)
    }


}

