//
//  DatePopupViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/8/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

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
        Main.appUser.birthday = formattedDate
        UserDefaults.standard.set(Main.appUser.birthday, forKey: "birthday")
        Main.databaseRef.child("Users").child(Main.appUser.uid!).child("birthday").setValue(Main.appUser.birthday)
        dismiss(animated: true)
        onSet?()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
