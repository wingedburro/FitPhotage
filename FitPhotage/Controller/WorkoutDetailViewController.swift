//
//  WorkoutDetailViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/14/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    
    private let cellsPerRow = 1
    
    private let detailFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.CustomColors.mainOrange, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        pc.numberOfPages = 1
        pc.currentPageIndicatorTintColor = UIColor.CustomColors.mainOrange
        pc.pageIndicatorTintColor = .gray
        pc.backgroundColor = .white
        
        return pc
    }()
    
    private var detailCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.CustomColors.whiteSmoke
        self.setupCollectionFlowLayout()
        self.customizeView()
    }
    
    override func viewWillLayoutSubviews() {
        let marginsAndInsets = detailFlowLayout.sectionInset.left + detailFlowLayout.sectionInset.right + detailCollectionView.safeAreaInsets.left + detailCollectionView.safeAreaInsets.right + detailFlowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let heightInsets = detailFlowLayout.sectionInset.top + detailFlowLayout.sectionInset.bottom + detailCollectionView.safeAreaInsets.top + detailCollectionView.safeAreaInsets.bottom
        let itemWidth = ((detailCollectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        let itemHeight = detailCollectionView.bounds.size.height - heightInsets
        detailFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    private func customizeView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailCollectionView.isPagingEnabled = true
        
        if let workout = WorkoutViewModel.currentWorkout {
            navigationItem.title = workout.name
            pageControl.numberOfPages = workout.progressionImages.count
        } else {
            navigationItem.title = "This Workout"
        }
        
        let pageControlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        pageControlsStackView.axis = .horizontal
        pageControlsStackView.distribution = .fillEqually
        pageControlsStackView.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        
        self.view.addSubview(detailCollectionView)
        self.view.addSubview(pageControlsStackView)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: detailCollectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: pageControlsStackView)
        let bottomInset = self.view.safeAreaInsets.bottom
        self.view.addConstraintsWithFormat(format: "V:|[v0]-0-[v1(50)]-\(bottomInset)-|", views: detailCollectionView, pageControlsStackView)
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupCollectionFlowLayout() {
        detailCollectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: detailFlowLayout)
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailCollectionView.backgroundColor = .white
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        detailCollectionView.contentInsetAdjustmentBehavior = .always
        detailCollectionView.register(WorkoutDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

}

extension WorkoutDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let workout = WorkoutViewModel.currentWorkout {
            return workout.progressionImages.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WorkoutDetailCell
        
        if let workout = WorkoutViewModel.currentWorkout {
            cell.workoutImageView.image = workout.progressionImages[indexPath.row % workout.progressionImages.count]
        }
        
        return cell
    }
}

extension WorkoutDetailViewController: UICollectionViewDelegate {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detailCollectionView.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}
