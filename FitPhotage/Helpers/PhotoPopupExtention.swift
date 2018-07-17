//
//  PhotoPopupViewExtension.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/11/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            DispatchQueue.main.async {
                picker.dismiss(animated: true, completion: nil)
            }
        }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWith Info: [String : Any]) {
            
            var selectedImageFromPicker: UIImage?
            
            if let editedImage = Info[UIImagePickerControllerEditedImage] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = Info[UIImagePickerControllerOriginalImage] as? UIImage {
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker{
                uploadImage.image = selectedImage
            }
            
            DispatchQueue.main.async {
                picker.dismiss(animated: true, completion: nil)
            }
            
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.present(picker, animated: true, completion: nil)
        }
    }
    
}
