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
        userRef = Database.database().reference().child("users").child(Main.appUser!.uid)
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
//        if uploadImage.image != nil {
//            let storageRef = Storage.storage().reference().child("testImage.png")
//
//            if let uploadData = UIImagePNGRepresentation(uploadImage.image!){
//                storageRef.putData(uploadData, metadata: nil)
//            }
//            print("successful dawg")
//        }
//        else {
//            print("Not entered")
//            dismiss(animated: true)
//        }
//        let timestamp = NSDate().timeIntervalSince1970
        
        // Unique Name for "Storage" in firebase to prevent duplicate Strings
        let imageName = NSUUID().uuidString
        
        // Retrieving Unix Timestamp and Converting it to date format
        let newestTime = Date().timeIntervalSince1970
        let date = NSDate.init(timeIntervalSince1970: newestTime)
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "MM-dd-YYYY-hh:mm:ss"
        let dateString = dateFormatted.string(from: date as Date)

        let uploadData = UIImagePNGRepresentation(#imageLiteral(resourceName: "LivFit"))
        let testImagesRef = self.storageRef.child("users").child(Main.appUser!.uid).child(imageName)
            
        testImagesRef.putData(uploadData!, metadata: nil) { [unowned self] (metadata, error) in
                guard let metadata = metadata else {
                    print("Error in Image Upload to Firebase")
                    return
                }
                guard let downloadURL = metadata.downloadURL()?.absoluteString else {
                    print("Error setting download URL")
                    return
                }
            
                // Taking ONLY THE FRONT IMAGE WITH THIS COMMAND
                self.userRef.child("front_images").child(dateString).setValue(downloadURL)
            }
        
        DispatchQueue.main.async { [unowned self] in
            self.dismiss(animated: true)
        }
    }
    
    
    
}
