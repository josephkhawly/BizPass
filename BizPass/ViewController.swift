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

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    
    //MARK: View Handling
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving(up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameField.delegate = self
        self.titleField.delegate = self
        self.emailField.delegate = self
        self.twitterField.delegate = self
        self.websiteField.delegate = self
        self.linkedinField.delegate = self
        self.resumeField.delegate = self
        self.phoneNumberField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button click method
    //If this method gets too crowded, we'll put the pass handling in a separate class.
    @IBAction func makeCard(sender: AnyObject) {
        //Check if the user's device has Passbook.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //If they do, start the PassSlot service.
            PassSlot.start("oalzIWdtIUZdOmQaaCtSQnRYzrHpFjSLeiLjBXiLlzMLOPLFmeoYYmvUljKyMacX")
            
            /**
            
            Create a pass from a template and request the installation of the pass
            @param template PassTemplate that is used to create the pass
            @param values Placeholder values that will be filled in
            @param images Array of PSImage for the pass
            @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
            @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
            
            
            PassSlot.createPassFromTemplate(<#template: PSPassTemplate!#>, withValues: <#[NSObject : AnyObject]!#>, withImages: <#[AnyObject]!#>, andRequestInstallation: <#UIViewController!#>, completion: <#PSCompletion!##() -> Void#>)
            */
            
        } else {
            
            // If they don't, present an alert controller and exit the app.
            let alertController = UIAlertController(title: "Well shit, son.", message: "Looks like you don't have Passbook on your device, which means this app is completely useless to you. Sorry.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}


