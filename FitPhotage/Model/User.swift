//
//  User.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/27/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var phone: String?
    var email: String?
    var program: FitnessProgram?
    var profileImageUrl: String?
}

enum FitnessProgram: String {
    case level1 = "Level 1"
    case xt = "XT"
}
