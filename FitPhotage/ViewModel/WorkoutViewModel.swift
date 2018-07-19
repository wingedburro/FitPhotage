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
    
    static func getWorkouts(completion: (() -> ())?) {
        DispatchQueue.global(qos: .userInteractive).async {
            let workoutRef = Database.database().reference().child("workouts")
            workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    if let dictionary = child.value as? [String: AnyObject] {
                        let description = dictionary["description"] as! String
                        let detail = dictionary["detail"] as! String
                        let detailImage = dictionary["detail_image"] as! String
                        let thumbnail = dictionary["thumbnail"] as! String
                        let workoutDetail = WorkoutDetail(workoutDetailDescription: detail, workoutDetailImageUrl: detailImage)
                        let newWorkout = Workout(workoutDescription: description, thumbnailUrl: thumbnail, workoutSet: [workoutDetail], isComplete: false)
                        workouts.append(newWorkout)
                    }
                }
            }, withCancel: nil)
            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
