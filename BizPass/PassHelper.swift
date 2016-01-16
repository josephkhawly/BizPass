//
//  PassHelper.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/22/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import PassKit
import AlertKit
import SwiftLoader

class PassHelper: NSObject {
    
    var values: [NSObject: AnyObject]
    var picture: UIImage
    weak var viewController: UIViewController!
    var pass: PSPass?
    var color: String
    
    init(values: [NSObject : AnyObject], picture: UIImage, color: String, viewController: UIViewController) {
        self.values = values
        self.picture = picture
        self.viewController = viewController
        self.color = color
        
        super.init()
        makePass()
    }
    
    func makePass() {
        
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //Start the loading indicator.
            SwiftLoader.show(title: "Creating your card...", animated: true)
            
            //Set the image to be displayed on the card.
            let image = PSImage(named: "Profile", ofType: .Thumbnail)
            image.setImage(picture, forResolution: .High)
            let imageArray = [image]
            
            colorSelection()
            
            //Create the card, add it to Passbook, and stop loading indicator when finished.
            PassSlot.passFromTemplateWithName("Business Card Template", withValues: values, withImages: imageArray, pass: {
                PSPass in
                
                //the pass is being stored into a variable because in a future release, the user will be able to edit their existing card, as opposed to making a brand-new one.
                self.pass = PSPass
                
                PassSlot.requestPassInstallation(self.pass, inViewController: self.viewController, completion: {
                    SwiftLoader.hide()
                })
                
            })
            
        } else {
            viewController.showAlert("Bad News", message: "You don't have Passbook on your device, so you can't use this app. Sorry.")
        }
    }
    
    //Set the color of the card based on user's selection
    func colorSelection() {
        
        switch self.color {
            
        case "Red": values["Color"] = "rgb(192,57,43)"
        case "Green": values["Color"] = "rgb(22,179,85)"
        case "Pink": values["Color"] = "rgb(215,125,169)"
        case "Orange": values["Color"] = "rgb(255,124,0)"
        case "Blue": values["Color"] = "rgb(61,171,255)"
        case "Purple": values["Color"] = "rgb(123,44,213)"
        case "Gray": values["Color"] = "rgb(121,121,121)"
        case "Brown": values["Color"] = "rgb(122,67,0)"
            
        default: values["Color"] = "rgb(192,57,43)"
            
        }
    }
}