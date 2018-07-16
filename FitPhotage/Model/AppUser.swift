//
//  AppUser.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/27/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

class AppUser: NSObject {
    // Personal User Information
    var name: String?
    var phone = UserDefaults.standard.object(forKey: "phone")
    var emailDefault = UserDefaults.standard.object(forKey: "email")
    var genderDefault = UserDefaults.standard.object(forKey: "gender")
    var programDefault = UserDefaults.standard.object(forKey: "program")
    var birthday = UserDefaults.standard.object(forKey: "birthday")

    // User Identifiers
    var uid: User?

    var program: FitnessProgram?
    var gender: Gender?
//    let photoURL = userID?.photoURL
//    let email2 = userID?.email
}
