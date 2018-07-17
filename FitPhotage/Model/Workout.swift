//
//  Workout.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/16/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class Workout {
    var workoutDescription: String
    var thumbnail: UIImage
    var workoutSet: [WorkoutDetail]
    var isComplete: Bool
    
    public init(workoutDescription: String, thumbnail: UIImage, workoutSet: [WorkoutDetail], isComplete: Bool) {
        self.workoutDescription = workoutDescription
        self.thumbnail = thumbnail
        self.workoutSet = workoutSet
        self.isComplete = isComplete
    }
    
    public init() {
        self.workoutDescription = "Workout"
        self.thumbnail = UIImage(named: "yoga.png")!
        self.workoutSet = [WorkoutDetail(workoutDetailDescription: "Workout", workoutDetailImage: UIImage(named: "yoga.png")!)]
        self.isComplete = false
    }
}

struct WorkoutDetail {
    var workoutDetailDescription: String
    var workoutDetailImage: UIImage
    
    public init(workoutDetailDescription: String, workoutDetailImage: UIImage) {
        self.workoutDetailDescription = workoutDetailDescription
        self.workoutDetailImage = workoutDetailImage
    }
    
    public init() {
        self.workoutDetailDescription = "Workout Detail"
        self.workoutDetailImage = UIImage(named: "yoga.png")!
    }
}
