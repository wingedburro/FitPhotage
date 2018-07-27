//
//  WorkoutViewModel.swift
//  FitPhotage
//
//  Created by Kevin Liao on 7/16/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class WorkoutViewModel {
    static var workouts = [Workout]()
    static var currentWorkout: Workout?
    
    static func getWorkouts(completion: (() -> ())?) {
        DispatchQueue.global(qos: .userInteractive).async {
            
            workouts = WorkoutData.workoutDict["Legs"]!
            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
