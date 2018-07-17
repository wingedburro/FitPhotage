//
//  Workout.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/16/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class Workout {
    var workoutDescription: String?
    var thumbnail: UIImage?
    var workoutSet: [WorkoutDetail]?
    var isComplete: Bool?
    
    public init(workoutDescription: String?, thumbnail: UIImage?, workoutSet: [WorkoutDetail]?, isComplete: Bool?) {
        self.workoutDescription = (workoutDescription != nil) ? workoutDescription : "Workout"
        self.thumbnail = (thumbnail != nil) ? thumbnail : UIImage(named: "yoga.png")
        self.workoutSet = (workoutSet != nil) ? workoutSet : [WorkoutDetail(workoutDetailDescription: "Workout", workoutDetailImage: UIImage(named: "yoga.png"))]
        self.isComplete = (isComplete != nil) ? isComplete : false
    }
}

struct WorkoutDetail {
    var workoutDetailDescription: String?
    var workoutDetailImage: UIImage?
    
    public init(workoutDetailDescription: String?, workoutDetailImage: UIImage?) {
        self.workoutDetailDescription = workoutDetailDescription
        self.workoutDetailImage = workoutDetailImage
    }
}
