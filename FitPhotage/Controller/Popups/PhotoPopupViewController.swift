//
//  PhotoPopupViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/11/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import UIKit

class PhotoPopupViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var onSet: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        handleSelectProfileImageView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
    }
    
    
    
}
