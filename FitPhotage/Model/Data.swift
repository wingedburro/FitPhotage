//
//  Data.swift
//  FitPhotage
//
//  Created by Weston Mauz on 6/17/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation

class Structure {
    var gender = ["Male","Female"]
    var program = ["Level 1","XT"]
    
    init(gender: [String]){
        self.gender = gender
    }
    
    init(program: [String]){
        self.program = program
    }
}

//class Genders {
//    var gender = ["Male","Female"]
//    
//    init(gender: [String]){
//        self.gender = gender
//    }
//}
//
//class Programs {
//    var program = ["Level 1","XT"]
//    
//    init(program: [String]){
//        self.program = program
//    }
//}
