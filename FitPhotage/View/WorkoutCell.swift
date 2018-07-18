//
//  WorkoutCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutCell: CustomCollectionViewCell {
    override var isSelected: Bool {
        didSet {
            self.transform = isSelected ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
//            self.contentView.backgroundColor = isSelected ? UIColor.lightGray : nil
//            self.thumbnailImageView.backgroundColor = isSelected ? UIColor.lightGray : nil
        }
    }
    
    var workout: Workout? {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                guard let urlString = self.workout?.thumbnailUrl else {
                    self.thumbnailImageView.image = UIImage(named: "yoga.png")
                    return
                }
                self.thumbnailImageView.loadImagesUsingCacheWithUrlString(urlString: urlString)
                self.descriptionLabelView.text = self.workout?.workoutDescription
                if let isComplete = self.workout?.isComplete {
                    if isComplete {
                        self.completionImageView.image = UIImage.init(named: "ok_icon")?.withRenderingMode(.alwaysTemplate)
                    } else {
                        self.completionImageView.image = UIImage(named: "checklist_icon")
                    }
                }
            }
        }
    }
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7.0
        return imageView
    }()
    
    var completionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.CustomColors.customOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        self.createHoverEffect()
        self.layer.cornerRadius = 7.0
        
        addSubview(thumbnailImageView)
        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        
        //Black Image inside of framing Rectangle
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-0-[v0(\(self.frame.height / 2))]-8-[v1]-8-|", views: thumbnailImageView, descriptionLabelView)
        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: completionImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: completionImageView, attribute: .height, relatedBy: .equal, toItem: completionImageView, attribute: .width, multiplier: 1, constant: 0))
        addConstraintsWithFormat(format: "H:|-8-[v0]-4-[v1(25)]-8-|", views: descriptionLabelView, completionImageView)
    }
}
