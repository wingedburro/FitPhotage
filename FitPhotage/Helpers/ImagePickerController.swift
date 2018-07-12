//
//  ImagePickerController.swift
//  FitPhotage
//
//  Created by Weston Mauz on 7/11/18.
//  Copyright © 2018 Winged Burro Studios. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWith Info: [String : Any]){
            
            var selectedImageFromPicker: UIImage?
            
            if let editedImage = Info[UIImagePickerControllerEditedImage] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = Info[UIImagePickerControllerOriginalImage] as? UIImage{
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker{
                uploadImage.image = selectedImage
            }
            
            picker.dismiss(animated: true, completion: nil)
        
        }
        

        
        
        present(picker, animated: true, completion: nil)
    }

}
