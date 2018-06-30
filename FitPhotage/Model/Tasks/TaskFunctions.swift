//
//  TaskFunctions.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/29/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation

class TaskFunctions {
    static func getTasks(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if (Data.userTasks.count == 0) {
                Data.userTasks.append(Task(description: "Read Documents", category: "Documents", isComplete: false))
                Data.userTasks.append(Task(description: "Update Fitness Program", category: "Profile", isComplete: false))
                Data.userTasks.append(Task(description: "Update Gender", category: "Profile", isComplete: false))
                Data.userTasks.append(Task(description: "Update Phone Number", category: "Profile", isComplete: false))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
