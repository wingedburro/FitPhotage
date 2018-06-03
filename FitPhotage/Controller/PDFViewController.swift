//
//  PDFViewController.swift
//  FitPhotage
//
//  Created by Kevin Liao on 6/2/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    let pdfTitle = "Sample-Qns-Exam2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pdfView = PDFView(frame: view.bounds)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        self.edgesForExtendedLayout = []
        view.addSubview(pdfView)
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: pdfView)
        view.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: pdfView)

        // Get pdf url
        if let path = Bundle.main.path(forResource: pdfTitle, ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                // pdfView.displayDirection = .horizontal
                pdfView.document = pdfDocument
            }
        }
    }
    
//    func captureThumbnails(pdfDocument:PDFDocument) {
//        if let page1 = pdfDocument.page(at: 1) {
//            page1ImageView.image = page1.thumbnail(of: CGSize(
//                width: page1ImageView.frame.size.width,
//                height: page1ImageView.frame.size.height), for: .artBox)
//        }
//
//        if let page2 = pdfDocument.page(at: 2) {
//            page2ImageView.image = page2.thumbnail(of: CGSize(
//                width: page2ImageView.frame.size.width,
//                height: page2ImageView.frame.size.height), for: .artBox)
//        }
//    }

}
