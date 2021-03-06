//
//  DocumentsViewController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 5/30/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.

import UIKit

class DocumentsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "DocumentCell"
    
    private let cellsPerRow = 3
    private let pdfList = ["Body Metrics Tracking Form", "Health History Questionnaire", "Lifestyle Questionnaire", "LivFit Waiver", "PARQ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        setupCollectionFlowLayout()
    }
    
    private func customizeView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor.CustomColors.whiteSmoke
        navigationItem.title = "Documents"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillLayoutSubviews() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 16)
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
        collectionView.register(DocumentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pdfList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DocumentCell
        cell?.setupViews(thumbnail: UIImage(named: "pdf_icon"), description: self.pdfList[indexPath.row])
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pdfViewController = PDFViewController()
        pdfViewController.pdfTitle = self.pdfList[indexPath.row]
        self.navigationController?.pushViewController(pdfViewController, animated: true)
//        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.center = self.view.center
//
//        let targetURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fitphotage.appspot.com/o/documents%2FBody%20Metrics%20Tracking%20Form.pdf?alt=media&token=18b2d3f0-fbb7-4855-820b-8d68b9d51be9")
//        let request = URLRequest(url: targetURL!)
//        webView.loadRequest(request)
//
//        view.addSubview(webView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}

