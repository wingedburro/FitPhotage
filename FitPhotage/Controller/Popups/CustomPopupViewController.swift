//
//  CustomPopupViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/24/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Firebase

class CustomPopupViewController: UIViewController {
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var popupPickerView: UIPickerView!
    @IBOutlet weak var popupView: UIView!
    
    var onSet: (() -> ())?
    
    let customPickerView = CustomPickerView()
    var popupLabelText: String = "Select Gender"
    var popupButtonText: String = "Set Gender"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
        
        popupPickerView.delegate = customPickerView
        popupPickerView.dataSource = customPickerView

        popupLabel.lineBreakMode = .byWordWrapping
        popupLabel.numberOfLines = 0
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupLabel.text = popupLabelText
        popupButton.setTitle(popupButtonText, for: .normal)
    }

    @IBAction func popupButtonAction(_ sender: Any) {
        if (popupLabelText == "Select Gender") {
//            Main.appUser.genderDef = (popupPickerView.selectedRow(inComponent: 0) == 0) ? Gender.male : Gender.female
            if popupPickerView.selectedRow(inComponent: 0) == 0 {
                Main.appUser.gender = Gender.male
                Main.appUser.genderDefault = Gender.male.rawValue
                UserDefaults.standard.set(Main.appUser.gender?.rawValue, forKey: "gender")
                Main.databaseRef.child("Users").child(Main.appUser.uid!).child("gender").setValue(Main.appUser.gender?.rawValue)
            }
            else {
                Main.appUser.gender = Gender.female
                Main.appUser.genderDefault = Gender.female.rawValue
                UserDefaults.standard.set(Main.appUser.gender?.rawValue, forKey: "gender")
                Main.databaseRef.child("Users").child(Main.appUser.uid!).child("gender").setValue(Main.appUser.gender?.rawValue)
            }
        } else {
//            Main.appUser.program = (popupPickerView.selectedRow(inComponent: 0) == 0) ? FitnessProgram.level1 : FitnessProgram.xt
            if popupPickerView.selectedRow(inComponent: 0) == 0 {
                Main.appUser.program = FitnessProgram.level1
                Main.appUser.programDefault = FitnessProgram.level1.rawValue
                UserDefaults.standard.set(Main.appUser.program?.rawValue, forKey: "program")
                Main.databaseRef.child("Users").child(Main.appUser.uid!).child("program").setValue(Main.appUser.program?.rawValue)
            }
            else {
                Main.appUser.program = FitnessProgram.xt
                Main.appUser.programDefault = FitnessProgram.xt.rawValue
                UserDefaults.standard.set(Main.appUser.program?.rawValue, forKey: "program")
                Main.databaseRef.child("Users").child(Main.appUser.uid!).child("program").setValue(Main.appUser.program?.rawValue)
            }
        }
        onSet?()
        self.dismiss(animated: false)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
