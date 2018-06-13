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
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    var completionImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.tintColor = UIColor.rgb(red: 3, green: 124, blue: 50)
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    var descriptionLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 12)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(thumbnail: UIImage(named: "pdf_icon"), description: "N/A", isComplete: false)
    }
    
    func setupViews(thumbnail: UIImage?, description: String?, isComplete: Bool) {
        createHoverEffect()
        
        thumbnailImageView.image = thumbnail
        descriptionLabelView.text = description
//        if isComplete {
//            completionImageView.image = UIImage.init(named: "ok_icon")?.withRenderingMode(.alwaysTemplate)
//        } else {
//            completionImageView.image = UIImage(named: "checklist_icon")
//        }
        
        addSubview(thumbnailImageView)
//        addSubview(completionImageView)
        addSubview(descriptionLabelView)
        
        //Black Image inside of framing Rectangle
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
//        addConstraintsWithFormat(format: "V:|-4-[v0(\(self.frame.height / 2))]-8-[v1]-8-|", views: thumbnailImageView, completionImageView)
        addConstraintsWithFormat(format: "V:|-4-[v0(\(self.frame.height / 2))]-8-[v1]-8-|", views: thumbnailImageView, descriptionLabelView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: descriptionLabelView)
//        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .top, relatedBy: .equal, toItem: completionImageView, attribute: .top, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: descriptionLabelView, attribute: .bottom, relatedBy: .equal, toItem: completionImageView, attribute: .bottom, multiplier: 1, constant: 9))
    }
    
    func createHoverEffect() {
        self.contentView.layer.cornerRadius = 2.5
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

