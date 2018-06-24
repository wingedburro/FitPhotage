//
//  CustomPopupViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/24/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class CustomPopupViewController: UIViewController {
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var popupPickerView: UIPickerView!
    
    let customPickerView = CustomPickerView()
    var popupLabelText: String = "Select Gender"
    var popupButtonText: String = "SET GENDER"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupPickerView.delegate = customPickerView
        popupPickerView.dataSource = customPickerView

        popupLabel.lineBreakMode = .byWordWrapping
        popupLabel.numberOfLines = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupLabel.text = popupLabelText
        popupButton.setTitle(popupButtonText, for: .normal)
    }

    @IBAction func popupButtonAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
}
