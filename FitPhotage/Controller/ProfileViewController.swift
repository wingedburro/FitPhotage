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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGray
//        setupLogoutButton()
        loadProfileInfo()
        self.setupNavbar()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadProfileInfo() {
        let imageHeight = view.frame.height/5
        let imageWidth = view.frame.height/5
        let profileImageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = UIColor.blue
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.darkGray
        view.addSubview(profileImageView)
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|-\((view.frame.width-imageWidth)/2)-[v0(\(view.frame.height/5))]-\((view.frame.width+imageWidth)/2)-|", views: profileImageView)
        view.addConstraintsWithFormat(format: "V:|-85-[v0(\(imageHeight))]-16-[v1]-0-|", views: profileImageView, tableView)
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
            case 0: return ProfileTableViewCell(style: .default, reuseIdentifier: "phoneCell", text: "Phone")
            case 1: return ProfileTableViewCell(style: .default, reuseIdentifier: "emailCell", text: "Email")
            case 2: return ProfileTableViewCell(style: .default, reuseIdentifier: "programsCell", text: "Programs")
            case 3: return ProfileTableViewCell(style: .default, reuseIdentifier: "birthCell", text: "Date of Birth")
            case 4: return ProfileTableViewCell(style: .default, reuseIdentifier: "genderCell", text: "Gender")
            default: fatalError("Unknown section")
            }
        case 1: return ProfileTableViewCell(style: .default, reuseIdentifier: "logoutCell", text: "Log out")
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Information"
        }
        return ""
    }
    
    
    
}
