//
//  ProfileViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let databaseRef = Database.database().reference()
    
    let profileImageView: ProfileImageView = {
        let imageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height / 5, height: UIScreen.main.bounds.height / 5))
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
        customizeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImageView.image = UIImage(named: "profile_icon")
//        if let imageUrl = Main.appUser.profileImageUrl {
//            profileImageView.loadImagesUsingCacheWithUrlString(urlString: imageUrl)
//        } else {
//            profileImageView.loadImagesUsingCacheWithUrlString(urlString: "https://firebasestorage.googleapis.com/v0/b/fitphotage.appspot.com/o/workout_images%2Fcropped_1.jpg?alt=media&token=6ec70f07-ed4d-43d7-9beb-69d781739260")
//        }
    }
    
    private func customizeView() {
        view.backgroundColor = UIColor.CustomColors.whiteSmoke
        navigationItem.title = Main.appUser.name ?? "You"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        AppDelegate.shared.rootViewController.goToLogout()
    }
    
    private func setupConstraints() {
        let imageWidth = view.frame.height / 5
        
        // Set up page constraints
        view.addSubview(profileImageView)
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|-\((view.frame.width-imageWidth)/2)-[v0(\(imageWidth))]", views: profileImageView)
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: tableView)
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: profileImageView, attribute: .width, multiplier: 1, constant: 1))
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
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
        let textHighlightColor = UIColor.CustomColors.customOrange
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cellText = "Phone: \(Main.appUser.phone ?? "Tap to update")"
                let phoneCell = ProfileTableViewCell(style: .default, reuseIdentifier: "phoneCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return phoneCell
            case 1:
                let cellText = "Email: \(Main.appUser.emailDefault ?? userID?.email ?? "N/A")"
                let emailCell = ProfileTableViewCell(style: .default, reuseIdentifier: "emailCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return emailCell
            case 2:
                let cellText = "Program: \(Main.appUser.programDefault ?? "Tap to select")"
                let programsCell = ProfileTableViewCell(style: .default, reuseIdentifier: "programsCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return programsCell
            case 3:
                let cellText = "Date of Birth: \(Main.appUser.birthday ?? "Tap to update")"
                let birthCell = ProfileTableViewCell(style: .default, reuseIdentifier: "birthCell", text: cellText, textHighlightColor: textHighlightColor, disclosure: true)
                return birthCell
            case 4:
                let cellText = "Gender: \(Main.appUser.genderDefault ?? "Tap to select")"
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
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let phonePopup = sb.instantiateViewController(withIdentifier: "PhonePopupViewController") as! PhonePopupViewController
                self.present(phonePopup, animated: true)
                phonePopup.onSet = { [unowned self] in
                    self.tableView.reloadData()
                }
            case 1:
                return
            case 2:
                self.definesPresentationContext = true
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let fitnessPickerPopup = sb.instantiateViewController(withIdentifier: "CustomPopupViewController") as! CustomPopupViewController
                fitnessPickerPopup.popupLabelText = "Select Fitness Program"
                fitnessPickerPopup.popupButtonText = "Set Program"
                fitnessPickerPopup.customPickerView.modelData = [FitnessProgram.level1.rawValue, FitnessProgram.xt.rawValue]
                self.present(fitnessPickerPopup, animated: true)
                fitnessPickerPopup.onSet = { [unowned self] in
                    self.tableView.reloadData()
                }
                return
            case 3:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let datePopup = sb.instantiateViewController(withIdentifier: "DatePopupViewController") as! DatePopupViewController
                self.present(datePopup, animated: true)
                datePopup.onSet = { [unowned self] in
                    self.tableView.reloadData()
                }
            case 4:
                self.definesPresentationContext = true
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let genderPickerPopup = sb.instantiateViewController(withIdentifier: "CustomPopupViewController") as! CustomPopupViewController
                genderPickerPopup.customPickerView.modelData = [Gender.male.rawValue, Gender.female.rawValue]
                self.present(genderPickerPopup, animated: true)
                genderPickerPopup.onSet = { [unowned self] in
                    self.tableView.reloadData()
                }
                return
            
            default: fatalError("Unknown section")
            }
        case 1:
           googleLogoutHandler()
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
