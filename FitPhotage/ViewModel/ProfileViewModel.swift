//
//  ProfileViewModel.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/15/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewModel {
    static var userInfo = [String: String]()
    static let userRef: DatabaseReference = {
        if let currentUser = Auth.auth().currentUser {
            return Database.database().reference().child("users").child(currentUser.uid)
        }
        
        let uid = Auth.auth().currentUser?.uid
        return Database.database().reference().child("users").child(uid!)
    }()
    
    static func updateUser(field: String, value: String, completion: (() -> ())?) {
        DispatchQueue.global(qos: .userInteractive).async {
            userRef.child(field).setValue(value)
            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
}
