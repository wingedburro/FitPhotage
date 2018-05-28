//
//  WorkoutCell.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        return imageView
    }()
    
    let completionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    let descriptionLabelView: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.green
        addSubview(backgroundImageView)
        addSubview(thumbnailImageView)
        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        
        //Black Image inside of framing Rectangle
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: backgroundImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(50)]-16-|", views: thumbnailImageView, completionImageView, descriptionLabelView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(50)]-16-|", views: descriptionLabelView, completionImageView)
        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .top, relatedBy: .equal, toItem: completionImageView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .bottom, relatedBy: .equal, toItem: completionImageView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
