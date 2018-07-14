//
//  ProgressViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProgressViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.CustomColors.whiteSmoke
        tableView.separatorColor = UIColor.CustomColors.whiteSmoke
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        customizeView()
        loadProfileInfo()
    }
    
    private func customizeView() {
        view.backgroundColor = UIColor.CustomColors.whiteSmoke
        navigationItem.title = "Your Progress"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func loadProfileInfo() {
        view.addSubview(tableView)

        view.addConstraintsWithFormat(format: "V:|-25-[v0]-|", views: tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
        case 0: return ProgressTableViewCell(style: .default, reuseIdentifier: "FrontCell", text: "Upload Picture", textHighlightColor: textHighlightColor, disclosure: true, progress: #imageLiteral(resourceName: "completed_icon"))
        case 1: return ProgressTableViewCell(style: .default, reuseIdentifier: "BackCell", text: "Upload Picture", textHighlightColor: textHighlightColor, disclosure: true, progress: #imageLiteral(resourceName: "check_icon"))
        case 2: return ProgressTableViewCell(style: .default, reuseIdentifier: "MeasurementCell", text: "Input Measurements", textHighlightColor: textHighlightColor, disclosure: true, progress: #imageLiteral(resourceName: "pending_icon2"))
        case 3: return ProgressTableViewCell(style: .default, reuseIdentifier: "BodyMetricsCell", text: "Input Body Metrics", textHighlightColor: textHighlightColor, disclosure: true, progress: #imageLiteral(resourceName: "pending_icon2"))
        case 4: return ProgressTableViewCell(style: .default, reuseIdentifier: "WeightCell", text: "Input Body Weight", textHighlightColor: textHighlightColor, disclosure: true, progress: #imageLiteral(resourceName: "timer_icon"))
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
//            handleSelectProfileImageView()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let photoPopup = sb.instantiateViewController(withIdentifier: "PhotoPopupViewController") as! PhotoPopupViewController
            self.present(photoPopup, animated: true)
            photoPopup.onSet = { [unowned self] in
                self.tableView.reloadData()
            }
        }
        if indexPath.section == 1 {
//            handleSelectProfileImageView()
        }
        if indexPath.section == 2 {
            self.navigationController?.pushViewController(MeasurementsViewController(), animated: true)
        }
        if indexPath.section == 3 {
//            self.navigationController?.pushViewController(ProfileViewController(), animated: true)

        }
        if indexPath.section == 4 {
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
        if section == 3 {
            return "Metrics"
        }
        if section == 4 {
            return "Weight"
        }
        return ""
    }
    
//    @objc func handleSelectProfileImage() {
//        let picker = UIImagePickerController()
//        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        picker.allowsEditing = true
//        present(picker, animated: true, completion: nil)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        var selectedImageFromPicker: UIImage?
//
//        if let editedImage = info["UIImagePickerControllerEditedImage"] {
//            selectedImageFromPicker = editedImage as? UIImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
//            selectedImageFromPicker = originalImage as? UIImage
//        }
//
////        if let selectedImage = selectedImageFromPicker {
////            self.profileImage.image = selectedImage
////            self.uploadProfileImageToDataBase(selectedImage: selectedImage)
////        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
    
    
}
