//
//  TaskCell.swift
//  FitPhotage
//
//  Created by Weston Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
//        imageView.image = UIImage(named: "profile_icon")
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    var completionImageView: UIImageView = {
        let imageView = UIImageView()
        let tintImage = UIImage.init(named: "seven_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.image = tintImage
        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    var descriptionLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.text = "N/A"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    var categoryLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.text = "Documents"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.blue
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(thumbnail: UIImage(named: "profile_icon"), backgroundColor: UIColor.white, description: "N/A", completedImage: UIImage(named: "one_icon"), isComplete: false)
    }
    
    init(thumbnail: UIImage?, backgroundColor: UIColor?, description: String?, completedImage: UIImage?, frame: CGRect, isComplete: Bool) {
        super.init(frame: frame)
        setupViews(thumbnail: thumbnail, backgroundColor: backgroundColor, description: description, completedImage: completedImage, isComplete: isComplete)
    }
    
    func setupViews(thumbnail: UIImage?, backgroundColor: UIColor?, description: String?, completedImage: UIImage?, isComplete: Bool) {
        thumbnailImageView.image = thumbnail
        backgroundImageView.backgroundColor = backgroundColor
        descriptionLabelView.text = description
        if isComplete {
            completionImageView.image = completedImage?.withRenderingMode(.alwaysTemplate)
        } else {
            completionImageView.image = completedImage
        }
        
        addSubview(backgroundImageView)
        addSubview(thumbnailImageView)
        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        addSubview(categoryLabelView)
        
        //Constraints
        addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "V:|-25-[v0(100)]-15-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "H:|-62.5-[v0(75)]-8-[v1]-62.5-|", views: thumbnailImageView, descriptionLabelView)
        addConstraintsWithFormat(format: "V:|-37.5-[v0(75)]|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-[v0(25)]-62.5-|", views: completionImageView)
        addConstraintsWithFormat(format: "V:|-37.5-[v0(50)]-|", views: descriptionLabelView)
        addConstraint(NSLayoutConstraint(item: completionImageView, attribute: .top, relatedBy: .equal, toItem: descriptionLabelView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completionImageView, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: categoryLabelView, attribute: .top, relatedBy: .equal, toItem: descriptionLabelView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: categoryLabelView, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: categoryLabelView, attribute: .left, relatedBy: .equal, toItem: descriptionLabelView, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: categoryLabelView, attribute: .right, relatedBy: .equal, toItem: completionImageView, attribute: .left, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

