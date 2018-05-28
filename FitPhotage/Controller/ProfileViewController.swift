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

class ProfileViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let statusBarBackgroundView: UIView = {
        let status = UIView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.backgroundColor = UIColor.black
        return status
    }()
    
    let phoneCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.blue
        cell.textLabel?.text = "Phone Number"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    let emailCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.green
        cell.textLabel?.text = "Email"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    let programsCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.orange
        cell.textLabel?.text = "Programs"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    let birthCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = "Date of Birth"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    let genderCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.purple
        cell.textLabel?.text = "Gender"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    let logoutCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.cyan
        cell.textLabel?.text = "Log out"
        cell.tintColor = UIColor.white
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
//        setupLogoutButton()
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
        view.addSubview(statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "V:|[v0(20)]|", views: statusBarBackgroundView)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        navBar.backgroundColor = UIColor.black
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = textAttributes
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = Main.appUser.name
        navBar.items = [navigationItem]
        view.addSubview(navBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: navBar)
        view.addConstraintsWithFormat(format: "V:|-20-[v0]", views: navBar)
    }
    
    @objc private func googleLogoutHandler() {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadProfileInfo() {
        let imageHeight = view.frame.height/5
        let imageWidth = view.frame.height/5
        let profileImageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = UIColor.blue
        view.addSubview(profileImageView)
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|-\((view.frame.width-imageWidth)/2)-[v0(\(view.frame.height/5))]-\((view.frame.width+imageWidth)/2)-|", views: profileImageView)
        view.addConstraintsWithFormat(format: "V:|-79-[v0(\(imageHeight))]-16-[v1]-0-|", views: profileImageView, tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return self.phoneCell
            case 1: return self.emailCell
            case 2: return self.programsCell
            case 3: return self.birthCell
            case 4: return self.genderCell
            default: fatalError("Unknown section")
            }
        case 1: return self.logoutCell
        default: fatalError("Unknown section")
        }
    }
    
    
    
}
