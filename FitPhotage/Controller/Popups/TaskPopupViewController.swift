//
//  TaskPopupViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/30/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class TaskPopupViewController: UIViewController {
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var didSet: ((_ isComplete: Bool) -> ())?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        completeButton.layer.cornerRadius = 3.0
        cancelButton.layer.cornerRadius = 3.0
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.didSet?(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
