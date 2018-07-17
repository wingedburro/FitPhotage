//
//  WorkoutDetailCell.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/14/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutDetailCell: CustomCollectionViewCell {
    
    var workoutDetail: WorkoutDetail? {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.workoutImageView.image = self.workoutDetail?.workoutDetailImage
                self.descriptionLabelView.text = self.workoutDetail?.workoutDetailDescription
            }
        }
    }
    
    var workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7.0
        return imageView
    }()
    
    var descriptionLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        descriptionLabelView.preferredMaxLayoutWidth = self.frame.width
        addSubview(descriptionLabelView)
        addSubview(workoutImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: descriptionLabelView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: workoutImageView)
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1]|", views: descriptionLabelView, workoutImageView)
    }
}
