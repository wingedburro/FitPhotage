//
//  Task.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/29/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class Task: NSObject {
    var taskDescription: String
    var category: String
    var isComplete: Bool
    var thumbnailImage: UIImage?
    
    public init(description: String, category: String, isComplete: Bool) {
        self.taskDescription = description
        self.category = category
        self.isComplete = isComplete
        self.thumbnailImage = UIImage(named: "task_icon")
    }
}
