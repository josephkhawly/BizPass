//
//  PhotoHelper.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/16/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit

//Function callback signature
typealias PhotoHelperCallback = UIImage? -> Void

class PhotoHelper: NSObject {
    
    // View controller on which AlertViewController and UIImagePickerController are presented
    weak var viewController: UIViewController!
    
    var callback: PhotoHelperCallback
    var imagePickerController: UIImagePickerController?
    
    
    //MARK: init method
    init(viewController: UIViewController, callback: PhotoHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        showPhotoSourceSelection()
    }
    
    //This function shows the dialog to select the photo source.
    //It is called when we initialize the helper.
    func showPhotoSourceSelection() {
        
        //Set up the alert controller
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil) //set up the cancel action.
        alertController.addAction(cancelAction) //Add the cancel button to the controller.
        
        
        if (UIImagePickerController.isCameraDeviceAvailable(.Front)) { // Set up and add the camera action, but only if the device has one.
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
                self.showImagePickerController(.Camera)
            }
            
            alertController.addAction(cameraAction)
        }
        
        //Set up and add the photo library action.
        let photoLibraryAction = UIAlertAction(title: "Photo From Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        
        alertController.addAction(photoLibraryAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //The function to show the photo library.
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
        
    }
}

extension PhotoHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
