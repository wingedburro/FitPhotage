//
//  PhonePopupViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/8/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class PhonePopupViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var label: UITextField!
    
    
    var onSet: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.keyboardType = UIKeyboardType.numberPad
        
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        if label.text != "" {
            ProfileViewModel.updateUser(field: "phone", value: label.text!, completion: nil)
            self.dismiss(animated: true)
            self.onSet?()
        }
    }
    
    
}

