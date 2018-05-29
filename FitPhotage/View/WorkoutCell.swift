//
//  WorkoutCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        return imageView
    }()
    
    let completionImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.red
        let tintImage = UIImage.init(named: "ok_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.image = tintImage
        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
        return imageView
    }()
    
    let descriptionLabelView: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor.purple
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
//        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.text = "Bicep Curls"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
  
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.rgb(red: 30, green: 30, blue: 30)
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
