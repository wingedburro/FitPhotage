//
//  Main.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/27/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Main {
    
    // Global Variables
    static var appUser: User?
    
    private init() {}
}

enum FitnessProgram: String {
    case level1 = "Level 1"
    case xt = "XT"
}

enum Gender: String {
    case male = "Male"
    case female = "Female"
}
