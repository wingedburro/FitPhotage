//
//  TaskCell.swift
//  FitPhotage
//
//  Created by Weston Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import Foundation

class TaskCell: CustomCollectionViewCell {
    override var isSelected: Bool {
        didSet {
            //self.transform = isSelected ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            self.contentView.backgroundColor = isSelected ? UIColor.lightGray : nil
            self.thumbnailImageView.backgroundColor = isSelected ? UIColor.lightGray : nil
        }
    }
    
    var task: Task? {
        didSet {
            thumbnailImageView.image = task?.thumbnailImage
            descriptionLabelView.text = task?.taskDescription
            categoryLabelView.text = task?.category
            if let isComplete = task?.isComplete {
                if isComplete {
                    completionImageView.image = UIImage.init(named: "ok_icon")?.withRenderingMode(.alwaysTemplate)
                } else {
                    completionImageView.image = UIImage(named: "checklist_icon")
                }
            }
            
        }
    }
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.CustomColors.whiteSmoke
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var completionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.text = "N/A"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Create separator line between each video cell
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var categoryLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 17)
        label.text = "Documents"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        addSubview(categoryLabelView)
        addSubview(separatorView)
        
        //Constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryLabelView)
        addConstraintsWithFormat(format: "H:|[v0(40)]-8-[v1]|", views: thumbnailImageView, descriptionLabelView)
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1(50)]-8-[v2(25)]-16-[v3(1)]|", views: categoryLabelView, descriptionLabelView, completionImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:[v0]|", views: completionImageView)
        
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: descriptionLabelView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completionImageView, attribute: .width, relatedBy: .equal, toItem: completionImageView, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: thumbnailImageView, attribute: .width, multiplier: 1, constant: 0))
    }
}

