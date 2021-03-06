//
//  TaskViewModel.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/29/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation

class TaskViewModel {
    static var userTasks = [Task]()
    
    static func getTasks(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if (userTasks.count == 0) {
                userTasks.append(Task(description: "Read Documents", category: "Documents", isComplete: false))
                userTasks.append(Task(description: "Update Fitness Program", category: "Profile", isComplete: false))
                userTasks.append(Task(description: "Update Gender", category: "Profile", isComplete: false))
                userTasks.append(Task(description: "Update Phone Number", category: "Profile", isComplete: false))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateTask(index: Int, isComplete: Bool, completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            userTasks[index].isComplete = isComplete
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
