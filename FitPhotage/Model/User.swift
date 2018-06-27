//
//  User.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/27/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

let userID = Auth.auth().currentUser

class User: NSObject {
    var name: String?
    var phone: String?
    var email: String?
    var program: FitnessProgram?
    var gender: Gender?
    var profileImageUrl: String?
    
    let uid = userID?.uid
    
    
    var phoneDef = UserDefaults.standard.object(forKey: "Phone")
    var genderDef = UserDefaults.standard.object(forKey: "Gender")
//    let photoURL = userID?.photoURL
//    let email2 = userID?.email
}
