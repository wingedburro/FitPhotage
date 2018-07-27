//
//  WorkoutsViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/28/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WorkoutsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    
    private let cellsPerRow = 2
    
    var workoutRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        self.navigationController?.hidesBarsOnSwipe = true
        
        workoutRef = Database.database().reference().child("workouts")
        
        // Grab workouts
        WorkoutViewModel.getWorkouts() { [unowned self] in
            self.collectionView?.reloadData()
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        setupCollectionFlowLayout()
    }
    
    private func customizeView() {
        let statusBarBackgroundView: UIView = {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.statusBarFrame.height))
            status.backgroundColor = UIColor.CustomColors.customLightOrange
            status.translatesAutoresizingMaskIntoConstraints = false
            return status
        }()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(statusBarBackgroundView)
        collectionView?.backgroundColor = UIColor.CustomColors.whiteSmoke
        navigationItem.title = "LivFit"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillLayoutSubviews() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 8)
    }
    
    // Necessary to get perfect columns
    private func setupCollectionFlowLayout() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 24
        flowLayout.sectionInset.top = 16
        flowLayout.sectionInset.bottom = 16
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.right = 16
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WorkoutViewModel.workouts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WorkoutCell
        cell?.workout = WorkoutViewModel.workouts[indexPath.row]
        return cell!
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let workoutDetailVC = WorkoutDetailViewController()
        WorkoutViewModel.currentWorkout = WorkoutViewModel.workouts[indexPath.row]
        self.present(UINavigationController(rootViewController: workoutDetailVC), animated: true)
    }

}
