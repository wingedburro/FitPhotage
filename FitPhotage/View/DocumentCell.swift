//
//  TaskCell.swift
//  FitPhotage
//
//  Created by Weston Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class DocumentCell: UICollectionViewCell {
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "profile_icon")
        return imageView
    }()
    
    var completionImageView: UIImageView = {
        let imageView = UIImageView()
        let tintImage = UIImage.init(named: "checklist_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.image = tintImage
        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
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
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(thumbnail: UIImage(named: "profile_icon"), backgroundColor: UIColor.white, description: "N/A", completedImage: UIImage(named: "checklist_icon"))
    }
    
    init(thumbnail: UIImage?, backgroundColor: UIColor?, description: String?, completedImage: UIImage?, frame: CGRect) {
        super.init(frame: frame)
        setupViews(thumbnail: thumbnail, backgroundColor: backgroundColor, description: description, completedImage: completedImage)
    }
    
    func setupViews(thumbnail: UIImage?, backgroundColor: UIColor?, description: String?, completedImage: UIImage?) {
        thumbnailImageView.image = thumbnail
        backgroundImageView.backgroundColor = backgroundColor
        descriptionLabelView.text = description
        completionImageView.image = completedImage
        
        addSubview(backgroundImageView)
        addSubview(thumbnailImageView)
        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        
        //Black Image inside of framing Rectangle
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-10-[v1(30)]-25-|", views: thumbnailImageView, completionImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(30)]-25-|", views: descriptionLabelView, completionImageView)
        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .top, relatedBy: .equal, toItem: completionImageView, attribute: .top, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .bottom, relatedBy: .equal, toItem: completionImageView, attribute: .bottom, multiplier: 1, constant: 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

