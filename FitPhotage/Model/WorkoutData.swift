//
//  WorkoutData.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutData {
    static let workoutDict: [String: [Workout]] = [
        "Legs": [Workout(thumbnail: UIImage(named: "yoga")!, week: 1, description: "Curl", name: "Barbell Deadlift", isComplete: false, progressionImages: [UIImage(named: "3_18_06")!, UIImage(named: "3_18_07")!, UIImage(named: "3_18_08")!])]
    ]
    
}
