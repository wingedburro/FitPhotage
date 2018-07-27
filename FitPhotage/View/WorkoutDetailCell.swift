//
//  WorkoutDetailCell.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/14/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutDetailCell: CustomCollectionViewCell {
    
    var workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7.0
        imageView.image = UIImage(named: "yoga")!
        return imageView
    }()
    
    override func setupViews() {
        addSubview(workoutImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: workoutImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: workoutImageView)
    }
}
