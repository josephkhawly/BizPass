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
    
    init(values: [NSObject : AnyObject], profile: UIImage, viewController: UIViewController) {
        self.values = values
        self.profile = profile
        self.viewController = viewController
        
        super.init()
        makePass()
        
    }
    
    func makePass() {
        //Check if the user's device has Passbook, just in case.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //Show the loading indicator in the middle of the view.
            SwiftLoader.show(title: "Creating your card...", animated: true)
            
            
            
        } else {
            //If the user doesn't have Passbook, we show them this:
            viewController.showAlert("Bad News", message: "You don't have Passbook on your device, so you can't use this app. Sorry.")
        }
    }
}