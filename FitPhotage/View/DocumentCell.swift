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
        setupViews(thumbnail: UIImage(named: "pdf_icon"), description: "N/A")
    }
    
    func setupViews(thumbnail: UIImage?, description: String?) {
        self.createHoverEffect()
        
        thumbnailImageView.image = thumbnail
        descriptionLabelView.text = description
        
        addSubview(thumbnailImageView)
        addSubview(descriptionLabelView)
        
        //Black Image inside of framing Rectangle
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-4-[v0(\(self.frame.height / 2))]-8-[v1]-8-|", views: thumbnailImageView, descriptionLabelView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: descriptionLabelView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

