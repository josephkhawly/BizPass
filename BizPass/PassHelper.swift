//
//  PassHelper.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/22/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import PassKit
import SwiftLoader
import AlertKit

class PassHelper: NSObject {
    
    var values: [NSObject: AnyObject]
    var profile: UIImage
    weak var viewController: UIViewController!
    var pass: PSPass?
    
    init(values: [NSObject : AnyObject], profile: UIImage, viewController: UIViewController) {
        self.values = values
        self.profile = profile
        self.viewController = viewController
        
        super.init()
        makePass()
    }
    
    //FIXME: The image shows up sideways on the card when taken with the camera
    func makePass() {
        
        //Check if the user's device has Passbook, just in case.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //Show the loading indicator in the middle of the view.
            SwiftLoader.show(title: "Creating your card...", animated: true)
            
            //Set the image to be displayed on the card.
            let image = PSImage(named: "Profile", ofType: .Thumbnail)
            image.setImage(profile, forResolution: .High)
            let imageArray = [image]
            
            //Create the card, store it in realm, add it to Passbook and stop loading indicator when finished.
            PassSlot.passFromTemplateWithName("Business Card Template", withValues: values, withImages: imageArray, pass: {
                PSPass in
                
                self.pass = PSPass
                
                PassSlot.requestPassInstallation(self.pass, inViewController: self.viewController, completion: {
                    SwiftLoader.hide()
                })
            })
            
        } else {
            //If the user doesn't have Passbook, we show them this:
            viewController.showAlert("Bad News", message: "You don't have Passbook on your device, so you can't use this app. Sorry.")
        }
    }
}