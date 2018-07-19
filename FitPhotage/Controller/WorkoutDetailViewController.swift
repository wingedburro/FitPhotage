//
//  WorkoutDetailViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/14/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    
    private let cellsPerRow = 1
    
    let statusBarBackgroundView: UIView = {
        let status = UIView(frame: .zero)
        status.backgroundColor = UIColor.CustomColors.customLightOrange
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    let navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: .zero)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = false
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navBar.titleTextAttributes = textAttributes
        return navBar
    }()
    
    let detailFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        flowLayout.minimumLineSpacing = 16
        return flowLayout
    }()
    
    var detailCollectionView: UICollectionView!
    
    var workoutDetails = [WorkoutDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionFlowLayout()
        self.customizeView()
    }
    
    private func customizeView() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = 44
        let collectionViewHeight = view.frame.height - statusBarHeight - navBarHeight
        let viewWidth = view.frame.width
        
        navigationItem.title = "This Workout"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navBar.items = [navigationItem]
        
        self.view.addSubview(statusBarBackgroundView)
        self.view.addSubview(navBar)
        self.view.addSubview(detailCollectionView)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0(\(viewWidth))]|", views: statusBarBackgroundView)
        self.view.addConstraintsWithFormat(format: "H:|[v0(\(viewWidth))]|", views: navBar)
        self.view.addConstraintsWithFormat(format: "H:|[v0(\(viewWidth))]|", views: detailCollectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0(\(statusBarHeight))]-0-[v1(\(navBarHeight))]-0-[v2(\(collectionViewHeight))]|", views: statusBarBackgroundView, navBar, detailCollectionView)
    }
    
    @objc private func dismissView() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillLayoutSubviews() {
        let marginsAndInsets = detailFlowLayout.sectionInset.left + detailFlowLayout.sectionInset.right + detailCollectionView.safeAreaInsets.left + detailCollectionView.safeAreaInsets.right + detailFlowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((detailCollectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        detailFlowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
    }
    
    private func setupCollectionFlowLayout() {
        detailCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: detailFlowLayout)
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailCollectionView.backgroundColor = UIColor.white
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        detailCollectionView.contentInsetAdjustmentBehavior = .always
        detailCollectionView.register(WorkoutDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.workoutDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WorkoutDetailCell
        
        cell.workoutDetail = self.workoutDetails[indexPath.row]
        
        return cell
    }

}
