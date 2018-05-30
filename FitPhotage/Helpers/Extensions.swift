//
//  Extensions.swift
//  FitPhotage
//
//  Created by Kevin Liao on 5/26/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

let statusBarBackgroundView: UIView = {
    let status = UIView()
    status.translatesAutoresizingMaskIntoConstraints = false
    return status
}()

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
        static let lead = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
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

extension UIViewController {
    
    func setupNavbar(navBarColor: UIColor?, statusBarColor: UIColor?, title: String?) {
        statusBarBackgroundView.backgroundColor = statusBarColor
        self.view.addSubview(statusBarBackgroundView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        self.view.addConstraintsWithFormat(format: "V:|[v0(26)]|", views: statusBarBackgroundView)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        navBar.backgroundColor = navBarColor
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = textAttributes
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = title
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: navBar)
        self.view.addConstraintsWithFormat(format: "V:|-26-[v0]", views: navBar)
    }
}
