//
//  WorkoutCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            //self.transform = isSelected ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            self.contentView.backgroundColor = isSelected ? UIColor.lightGray : nil
            self.thumbnailImageView.backgroundColor = isSelected ? UIColor.lightGray : nil
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(thumbnail: UIImage(named: "profile_icon"), description: "N/A", isComplete: false)
    }
    
    init(thumbnail: UIImage?, description: String?, frame: CGRect, isComplete: Bool) {
        super.init(frame: frame)
        setupViews(thumbnail: thumbnail, description: description, isComplete: isComplete)
    }
    
    func setupViews(thumbnail: UIImage?, description: String?, isComplete: Bool) {
        self.createHoverEffect()
        self.layer.cornerRadius = 7.0
        
        thumbnailImageView.image = thumbnail
        descriptionLabelView.text = description
        if isComplete {
            completionImageView.image = UIImage.init(named: "ok_icon")?.withRenderingMode(.alwaysTemplate)
        } else {
            completionImageView.image = UIImage(named: "checklist_icon")
        }
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
