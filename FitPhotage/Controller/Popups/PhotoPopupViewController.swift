//
//  PhotoPopupViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/11/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class PhotoPopupViewController: UIViewController {
    
    var userRef: DatabaseReference!
    var storageRef: StorageReference!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var onSet: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRef = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        storageRef = Storage.storage().reference()
        
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
        
        // KEEP THESE COMMENTS FOR WHEN WE ARE ABLE TO RETRIEVE IMAGE FROM PICKER
        if uploadImage.image != nil {
            // Retrieving Unix Timestamp and Converting it to date format
            let newestTime = Date().timeIntervalSince1970
            let date = NSDate.init(timeIntervalSince1970: newestTime)
            let dateFormatted = DateFormatter()
            dateFormatted.dateFormat = "MM-dd-YYYY-hh:mm:ss"
            let dateString = dateFormatted.string(from: date as Date)
            
            // Unique Name for "Storage" in firebase to prevent duplicate Strings
            let imageName = NSUUID().uuidString
            
            let imageRef = self.storageRef.child("users").child((Auth.auth().currentUser?.uid)!).child(imageName)

            if let uploadData = UIImageJPEGRepresentation(uploadImage.image!, 0.8) {
                imageRef.putData(uploadData, metadata: nil) { [unowned self] (metadata, error) in
                    if error != nil {
                        DispatchQueue.main.async { [unowned self] in
                            self.dismiss(animated: true)
                        }
                        return
                    }
                    
                    guard let metadata = metadata else {
                        print("Error in Image Upload to Firebase")
                        DispatchQueue.main.async { [unowned self] in
                            self.dismiss(animated: true)
                        }
                        return
                    }
                    
                    guard let downloadURL = metadata.downloadURL()?.absoluteString else {
                        print("Error setting download URL")
                        DispatchQueue.main.async { [unowned self] in
                            self.dismiss(animated: true)
                        }
                        return
                    }
                    
                    // Taking ONLY THE FRONT IMAGE WITH THIS COMMAND
                    self.userRef.child("front_images").child(dateString).setValue(downloadURL)
                    
                    DispatchQueue.main.async { [unowned self] in
                        self.dismiss(animated: true)
                    }
                }
            }
        } else {
            DispatchQueue.main.async { [unowned self] in
                self.dismiss(animated: true)
            }
        }
    }
    
    
    
}
