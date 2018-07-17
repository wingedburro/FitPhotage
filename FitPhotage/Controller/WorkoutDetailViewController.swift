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
    
    let detailFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        flowLayout.minimumLineSpacing = 16
        return flowLayout
    }()
    
    var detailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    var workoutDetails = [WorkoutDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
        
        setupCollectionFlowLayout()
    }
    
    private func customizeView() {
        let statusBarBackgroundView: UIView = {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.statusBarFrame.height))
            status.backgroundColor = UIColor.CustomColors.customLightOrange
            status.translatesAutoresizingMaskIntoConstraints = false
            return status
        }()
        
        view.addSubview(statusBarBackgroundView)
        navigationItem.title = "This Workout"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillLayoutSubviews() {
        let marginsAndInsets = detailFlowLayout.sectionInset.left + detailFlowLayout.sectionInset.right + detailCollectionView.safeAreaInsets.left + detailCollectionView.safeAreaInsets.right + detailFlowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((detailCollectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        detailFlowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
    }
    
    private func setupCollectionFlowLayout() {
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        detailCollectionView.collectionViewLayout = detailFlowLayout
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
