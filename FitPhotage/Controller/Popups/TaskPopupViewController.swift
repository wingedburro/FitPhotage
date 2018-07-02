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

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        
        completeButton.layer.cornerRadius = 3.0
        cancelButton.layer.cornerRadius = 3.0
    }
    
    override func viewWillLayoutSubviews() {
        let amountMoved = (view.bounds.height / 6) + 16
        completeButton.center.y += amountMoved
        cancelButton.center.y += amountMoved
    }
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            let amountMoved = (self.view.bounds.height / 6) + 16
            self.completeButton.center.y -= amountMoved
            self.cancelButton.center.y -= amountMoved
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            let amountMoved = (self.view.bounds.height / 6) + 16
            self.completeButton.center.y += amountMoved
            self.cancelButton.center.y += amountMoved
        }, completion: nil)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.didSet?(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
