//
//  WorkoutsViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    private let cellsPerRow = 2
    
    let statusBarBackgroundView: UIView = {
        let status = UIView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.backgroundColor = UIColor.black
        return status
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.blue

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        setupCollectionFlowLayout()
        setupNavbar()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    private func setupNavbar() {
        view.addSubview(statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        view.addConstraintsWithFormat(format: "V:|[v0(20)]|", views: statusBarBackgroundView)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        navBar.backgroundColor = UIColor.black
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = textAttributes
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "LivFit"
        navBar.items = [navigationItem]
        view.addSubview(navBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: navBar)
        view.addConstraintsWithFormat(format: "V:|-20-[v0]", views: navBar)
    }
    
    // Necessary to get perfect columns
    private func setupCollectionFlowLayout() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

}
