//
//  ViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/9/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import PassKit

    /* Possible methods and classes to use:
        Classes: PKPassLibrary, PKAddPassesViewController
        Methods: isPassLibraryAvailable() -> Bool
                    passes() -> [PKPass]
                    passWithPassTypeIdentifier(identifier: String, serialNumber: String)->PKPass?
                    addPasses(...)
                    canAddPasses()
                    init(pass)

        Think about using a table view instead.

        Feature suggestion: have the user choose whatever info that isn't their name and title to present on the front of the card.
     */

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    @IBOutlet weak var githubField: UITextField!
    
    
    //If this method gets too crowded, we'll put the pass handling in a separate class.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if the user's device has Passbook.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //If they do, start the PassSlot service.
            PassSlot.start("oalzIWdtIUZdOmQaaCtSQnRYzrHpFjSLeiLjBXiLlzMLOPLFmeoYYmvUljKyMacX")
            
            /*
            
            the method for creating a pass.
            
            PassSlot.createPassFromTemplate(<#template: PSPassTemplate!#>, withValues: <#[NSObject : AnyObject]!#>, withImages: <#[AnyObject]!#>, andRequestInstallation: <#UIViewController!#>, completion: <#PSCompletion!##() -> Void#>)
            */
            
        } else {
            
            // If they don't, present an alert controller and exit the app.
            let alertController = UIAlertController(title: "Well shit, son.", message: "Looks like you don't have Passbook.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


