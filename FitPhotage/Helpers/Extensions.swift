//
//  Extensions.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
    
}

extension UIColor {
    
    struct CustomColors {
        static let lead = UIColor.rgb(red: 30, green: 30, blue: 30)
        static let mainOrange = UIColor.rgb(red: 255, green: 87, blue: 34)
        static let accent = UIColor.rgb(red: 96, green: 125, blue: 139)
        static let primaryText = UIColor.rgb(red: 33, green: 33, blue: 33)
        static let lightOrange = UIColor.rgb(red: 255, green: 204, blue: 188)
        static let customOrange = UIColor.rgb(red: 255, green: 112, blue: 67)
        static let customDarkOrange = UIColor.rgb(red: 244, green: 81, blue: 30)
        static let whiteSmoke = UIColor.rgb(red: 248, green: 249, blue: 251)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    // Shortcut and modularized code for adding constraints
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

extension UIImageView {
    // Function to cache images
    func loadImagesUsingCacheWithUrlString(urlString: String) {
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        // Otherwise fire off new download
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}

extension UICollectionViewCell {
    
    // Create floating card effect
    func createHoverEffect() {
        self.contentView.layer.cornerRadius = 5
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
    
}

extension Date {
    func toMillis() -> String {
        return String(self.timeIntervalSince1970 * 1000)
    }
}
