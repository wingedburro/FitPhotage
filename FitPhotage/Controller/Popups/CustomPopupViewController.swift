//
//  CustomPopupViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/24/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

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
            if popupPickerView.selectedRow(inComponent: 0) == 0 {
                ProfileViewModel.updateUser(field: "gender", value: Gender.male.rawValue, completion: nil)
            }
            else {
                ProfileViewModel.updateUser(field: "gender", value: Gender.female.rawValue, completion: nil)
            }
        } else {
            if popupPickerView.selectedRow(inComponent: 0) == 0 {
                ProfileViewModel.updateUser(field: "program", value: FitnessProgram.level1.rawValue, completion: nil)
            } else {
                ProfileViewModel.updateUser(field: "program", value: FitnessProgram.xt.rawValue, completion: nil)
            }
        }
        onSet?()
        self.dismiss(animated: false)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
