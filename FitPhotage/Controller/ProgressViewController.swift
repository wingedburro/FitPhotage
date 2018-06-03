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

class ProgressViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.CustomColors.lead
        loadProfileInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavbar(navBarColor: UIColor.CustomColors.lead, statusBarColor: UIColor.CustomColors.lead, title: "Weekly Check-in")
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.CustomColors.lead
        tableView.separatorColor = UIColor.CustomColors.lead
        return tableView
    }
    
    
    private func loadProfileInfo() {
        let imageHeight = view.frame.height/5
        let imageWidth = view.frame.height/5
        let profileImageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = UIColor.blue
        let tableView = createTableView()
        view.addSubview(profileImageView)
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|-\((view.frame.width-imageWidth)/2)-[v0(\(view.frame.height/5))]-\((view.frame.width+imageWidth)/2)-|", views: profileImageView)
        view.addConstraintsWithFormat(format: "V:|-85-[v0(\(imageHeight))]-16-[v1]-0-|", views: profileImageView, tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
    }
    
    private func createCustomSeparator(cellHeight: CGFloat) -> UIView {
        let separatorHeight = CGFloat(2.0)
        let customSeparator = UIView.init(frame: CGRect(x: 0, y: cellHeight-separatorHeight, width: view.frame.width, height: separatorHeight))
        customSeparator.backgroundColor = UIColor.CustomColors.lead
        return customSeparator
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textHighlightColor = UIColor.orange
        switch indexPath.section {
        case 0: return ProfileTableViewCell(style: .default, reuseIdentifier: "FrontCell", text: "Upload Picture", textHighlightColor: textHighlightColor, disclosure: true)
        case 1: return ProfileTableViewCell(style: .default, reuseIdentifier: "BackCell", text: "Upload Picture", textHighlightColor: textHighlightColor, disclosure: true)
        case 2: return ProfileTableViewCell(style: .default, reuseIdentifier: "MeasurementCell", text: "Input Measurements", textHighlightColor: textHighlightColor, disclosure: true)
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            handleSelectProfileImage()
        }
        if indexPath.section == 1 {
            handleSelectProfileImage()
        }
        if indexPath.section == 2 {
//            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Front Image"
        }
        if section == 1 {
            return "Back Image"
        }
        if section == 2 {
            return "Measurements"
        }
        return ""
    }
    
    @objc func handleSelectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImageFromPicker = editedImage as? UIImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        
//        if let selectedImage = selectedImageFromPicker {
//            self.profileImage.image = selectedImage
//            self.uploadProfileImageToDataBase(selectedImage: selectedImage)
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
