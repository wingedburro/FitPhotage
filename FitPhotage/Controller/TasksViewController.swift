//
//  TasksViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/30/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit

class TasksViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    
    private let cellsPerRow = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        TaskViewModel.getTasks { [unowned self] in
            self.collectionView?.reloadData()
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        setupCollectionFlowLayout()
    }
    
    private func customizeView() {
        collectionView?.backgroundColor = UIColor.CustomColors.whiteSmoke
        navigationItem.title = "Today's Tasks"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillLayoutSubviews() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 125) // 125 comes from manual constraint calculation
    }
    
    // Necessary to get perfect columns
    private func setupCollectionFlowLayout() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset.top = 16
        flowLayout.sectionInset.bottom = 16
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.right = 16
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return TaskViewModel.userTasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TaskCell
        if indexPath.row < TaskViewModel.userTasks.count {
            cell?.task = TaskViewModel.userTasks[indexPath.row]
        }
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.definesPresentationContext = true
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tasksPopup = sb.instantiateViewController(withIdentifier: "TaskPopupViewController") as! TaskPopupViewController
        tasksPopup.didSet = { (isComplete) in
            TaskViewModel.updateTask(index: indexPath.row, isComplete: isComplete, completion: { [unowned self] in
                self.collectionView?.reloadData()
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
        
        self.present(tasksPopup, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}
