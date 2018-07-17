//
//  DatePopupViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/8/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DatePopupViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    var onSet: (() -> ())?
    
    var formattedDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: datePicker.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
    }

    @IBAction func confirmAction(_ sender: Any) {
        ProfileViewModel.updateUser(field: "birthday", value: formattedDate) { [unowned self] in
            self.onSet?()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
