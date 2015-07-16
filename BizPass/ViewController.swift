//
//  ViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/9/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import PassKit

    /* Feature suggestions: have the user choose whatever info that isn't their name and title to present on the front of the card.

        Let the user decide the color of the card.
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
    
    var photoHelper: PhotoHelper?
    var photo: UIImage?
    
    
    //MARK: UITextFieldDelegate Methods
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        
        //Add the tap gesture to the ImageView
        let tapGesture = UIGestureRecognizer(target: self, action: Selector("uploadImage:"))
        imageView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button click method
    @IBAction func makeCard(sender: AnyObject) {
        
        //Check if the user's device has Passbook.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //These are the minimum requirements for generating a card.
            if nameField.text != "" && titleField.text != "" && emailField.text != "" && phoneNumberField.text != "" {
                
                //If they do, start the PassSlot service.
                PassSlot.start("sVSUwmfkUQdmOsFjZPvFqmeUqQPeLqnhthejrVRVwgBNbWUFLOtfwlFUSWRuvdQQ")
                
                //Store the user values into an array
                var values : [NSObject: AnyObject] = ["Name": "\(nameField.text)", "Title": "\(titleField.text)", "Email": "\(emailField.text)", "Phone": "\(phoneNumberField.text)"]
                
                if twitterField.text != "" { values["Twitter"] = ["\(twitterField.text)"] }
                if websiteField.text != "" { values["Website"] = ["\(websiteField.text)"] }
                if linkedinField.text != "" { values["Linkedin"] = ["\(linkedinField.text)"] }
                if resumeField.text != "" { values["Resume"] = ["\(resumeField.text)"] }
                
                
                let image = PSImage(named: "Profile", ofType: .Thumbnail)
                image.setImage(photo, forResolution: .High)
                
                let imageArray = [image]
                
                PassSlot.createPassFromTemplateWithName("Business Card Template", withValues: values, withImages: imageArray, andRequestInstallation: self, completion: nil)
                
            } else {
                //If the requirements are not met, show the user an alert dialog.
                displayAlert("Hey, not so fast.", message: "You need to at least have your name, title, email address, phone number, and a photo in order to generate a card. Everything else is optional.", preferredStyle: .Alert)
            }
            
        } else {
            //If the user doesn't have Passbook, we show them this:
            displayAlert("Well shit, son.", message: "You don't have Passbook on your device, so you can't use this app. Sorry.", preferredStyle: .Alert)
        }
    }
    
    //A single method to display an alert controller for convenience purposes
    func displayAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Image upload
    @IBAction func uploadImage(sender: UITapGestureRecognizer) {
        photoHelper = PhotoHelper(viewController: self) { (image: UIImage?) in
            self.imageView.image = image
            self.photo = image
        }
    }
}