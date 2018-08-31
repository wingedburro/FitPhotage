//
//  ProfileViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var userRef: DatabaseReference!
    var profileListener: DatabaseHandle!
    
    let profileImageView: ProfileImageView = {
        let imageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height / 5, height: UIScreen.main.bounds.height / 5))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.CustomColors.whiteSmoke
        tableView.separatorColor = UIColor.CustomColors.whiteSmoke
        tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        checkIfUserLoggedIn()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
        customizeView()
    }
    
    private func customizeView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = UIColor.CustomColors.mainOrange
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.CustomColors.primaryText]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func checkIfUserLoggedIn() {
        if let user = Auth.auth().currentUser {
            self.userRef = Database.database().reference().child("users").child(user.uid)
        } else {
            self.perform(#selector(self.handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance().signOut()
            AppDelegate.shared.rootViewController.goToLogout()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    @objc private func logoutHandler() {
        for user in (Auth.auth().currentUser?.providerData)! {
            if (user.providerID == "google.com") {
                GIDSignIn.sharedInstance().signOut()
                AppDelegate.shared.rootViewController.goToLogout()
            } else {
                do {
                    try Auth.auth().signOut()
                    AppDelegate.shared.rootViewController.goToLogout()
                } catch let logoutError {
                    print(logoutError)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Load profile image from cache
        DispatchQueue.main.async { [unowned self] in
            if let imageUrl = ProfileViewModel.userInfo["profileImageUrl"] {
                self.profileImageView.loadImagesUsingCacheWithUrlString(urlString: imageUrl)
            } else {
                self.profileImageView.image = UIImage.init(named: "profile_icon")?.withRenderingMode(.alwaysTemplate)
                self.profileImageView.tintColor = .white
                self.profileImageView.backgroundColor = UIColor.CustomColors.accent
            }
        }
        
        // Set listeners
        if userRef != nil {
            self.profileListener = userRef.observe(.value, with: { [unowned self] (snapshot) in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    ProfileViewModel.userInfo[child.key] = child.value as? String
                }
                
                DispatchQueue.main.async {
                    self.navigationItem.title = ProfileViewModel.userInfo["name"] ?? "You"
                    self.tableView.reloadData()
                }
            }, withCancel: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if userRef != nil {
            self.userRef.removeAllObservers()
        }
    }
    
    private func setupLogoutButton() {
        let logoutButton = UIButton(frame: CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 24, width: 200, height: 48))
        logoutButton.backgroundColor = UIColor.orange
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutHandler), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        let imageWidth = view.frame.height / 5
        
        // Set up page constraints
        view.addSubview(profileImageView)
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|-\((view.frame.width-imageWidth)/2)-[v0(\(imageWidth))]", views: profileImageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: profileImageView, attribute: .width, multiplier: 1, constant: 1))
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 24))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        
        profileImageView.layer.borderColor = UIColor.clear.cgColor;
        profileImageView.layer.borderWidth = 0.5;
        profileImageView.layer.shadowColor = UIColor.black.cgColor;
        profileImageView.layer.shadowOffset = CGSize(width: 0, height: 1.0);
        profileImageView.layer.shadowRadius = 5.0;
        profileImageView.layer.shadowOpacity = 0.5;
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
        let textHighlightColor = UIColor.CustomColors.mainOrange
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cellText = "Phone: \(String(describing: ProfileViewModel.userInfo["phone"] ?? "Tap to update"))"
                let phoneCell = ProfileTableViewCell(style: .default, reuseIdentifier: "phoneCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return phoneCell
            case 1:
                let cellText = "Email: \(String(describing: ProfileViewModel.userInfo["email"] ?? "N/A"))"
                let emailCell = ProfileTableViewCell(style: .default, reuseIdentifier: "emailCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return emailCell
            case 2:
                let cellText = "Program: \(String(describing: ProfileViewModel.userInfo["program"] ?? "Tap to select"))"
                let programsCell = ProfileTableViewCell(style: .default, reuseIdentifier: "programsCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return programsCell
            case 3:
                let cellText = "Date of Birth: \(String(describing: ProfileViewModel.userInfo["birthday"] ?? "Tap to select"))"
                let birthCell = ProfileTableViewCell(style: .default, reuseIdentifier: "birthCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return birthCell
            case 4:
                let cellText = "Gender: \(String(describing: ProfileViewModel.userInfo["gender"] ?? "Tap to select"))"
                return ProfileTableViewCell(style: .default, reuseIdentifier: "genderCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
            default: fatalError("Unknown section")
            }
        case 1:
            return ProfileTableViewCell(style: .default, reuseIdentifier: "logoutCell", text: "Log out", textHighlightColor: textHighlightColor, disclosure: true)
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.definesPresentationContext = true
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let phonePopup = sb.instantiateViewController(withIdentifier: "PhonePopupViewController") as! PhonePopupViewController
                DispatchQueue.main.async {
                    self.present(phonePopup, animated: true)
                }
                phonePopup.onSet = { [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                return
            case 1:
                return
            case 2:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let fitnessPickerPopup = sb.instantiateViewController(withIdentifier: "CustomPopupViewController") as! CustomPopupViewController
                fitnessPickerPopup.popupLabelText = "Select Fitness Program"
                fitnessPickerPopup.popupButtonText = "Set Program"
                fitnessPickerPopup.customPickerView.modelData = [FitnessProgram.level1.rawValue, FitnessProgram.xt.rawValue]
                DispatchQueue.main.async {
                    self.present(fitnessPickerPopup, animated: true)
                }
                fitnessPickerPopup.onSet = { [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                return
            case 3:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let datePopup = sb.instantiateViewController(withIdentifier: "DatePopupViewController") as! DatePopupViewController
                DispatchQueue.main.async {
                    self.present(datePopup, animated: true)
                }
                datePopup.onSet = { [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                return
            case 4:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let genderPickerPopup = sb.instantiateViewController(withIdentifier: "CustomPopupViewController") as! CustomPopupViewController
                genderPickerPopup.customPickerView.modelData = [Gender.male.rawValue, Gender.female.rawValue]
                DispatchQueue.main.async {
                    self.present(genderPickerPopup, animated: true)
                }
                genderPickerPopup.onSet = { [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                return
            
            default: fatalError("Unknown section")
            }
        case 1:
           logoutHandler()
        default: fatalError("Unknown section")
        }
    }
    
    @objc func datePickerValueChanged(_sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedData: String = dateFormatter.string(from: _sender.date)
        print(selectedData)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Information"
        }
        return ""
    }
    
}
