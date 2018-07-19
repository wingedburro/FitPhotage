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
    var thumbnailUrl: String
    var workoutSet: [WorkoutDetail]
    var isComplete: Bool
    
    public init(workoutDescription: String, thumbnailUrl: String, workoutSet: [WorkoutDetail], isComplete: Bool) {
        self.workoutDescription = workoutDescription
        self.thumbnailUrl = thumbnailUrl
        self.workoutSet = workoutSet
        self.isComplete = isComplete
    }
    
    public init() {
        self.workoutDescription = "Workout"
        self.thumbnailUrl = "yoga.png"
        self.workoutSet = [WorkoutDetail()]
        self.isComplete = false
    }
}

struct WorkoutDetail {
    var workoutDetailDescription: String
    var workoutDetailImageUrl: String
    
    public init(workoutDetailDescription: String, workoutDetailImageUrl: String) {
        self.workoutDetailDescription = workoutDetailDescription
        self.workoutDetailImageUrl = workoutDetailImageUrl
    }
    
    public init() {
        self.workoutDetailDescription = "Workout Detail"
        self.workoutDetailImageUrl = "yoga.png"
    }
}
