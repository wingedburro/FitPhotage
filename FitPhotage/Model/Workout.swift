//
//  Workout.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/16/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class Workout {
    var thumbnail: UIImage
    var week: Int
    var description: String
    var name: String
    var isComplete: Bool
    var progressionImages: [UIImage]
    
    public init(thumbnail: UIImage, week: Int, description: String, name: String, isComplete: Bool, progressionImages: [UIImage]) {
        
        self.thumbnail = thumbnail
        self.week = week
        self.description = description
        self.name = name
        self.isComplete = isComplete
        self.progressionImages = progressionImages
    }
    
//    init() {
//        self.thumbnail = UIImage()
//        self.week = 1
//        self.description = "Help too hard"
//        self.name = "This workout will crush you"
//        self.isComplete = false
//        self.progressionImages
//    }
    
    
}
