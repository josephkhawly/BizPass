//
//  ViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/9/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import PassKit
import SwiftLoader
import AlertKit

    /* Feature suggestions: 
        
        -have the user choose whatever info that isn't their name and title to present on the front of the card.

        -Let the user decide the color of the card.
        
        -Let the user update info on their existing card instead of making a new one.

        Small Stuff That Needs to be Done Before Shipping:
            Have something happen if the user isn't connected to the internet.
            Remove sample data. */

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlets and variables
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    
    var photoHelper: PhotoHelper?
    var photo: UIImage?
    
    //MARK: viewDidLoad Method
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
        self.companyField.delegate = self
        
        //Add the tap gestures
        let imageTapGesture = UIGestureRecognizer(target: self, action: Selector("uploadImage:"))
        imageView.addGestureRecognizer(imageTapGesture)
        
        let dismissGesture = UIGestureRecognizer(target: self, action: Selector("dismissKeyboard:"))
        self.view.addGestureRecognizer(dismissGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Keyboard management
    func textFieldDidBeginEditing(textField: UITextField) {
        //Hide the imageView and move all the textFields up so the keyboard doesn't hide them
        imageView.hidden = true
        animateViewMoving(true, moveValue: 120)
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //Do the opposite when done editing.
        imageView.hidden = false
        animateViewMoving(false, moveValue: 120)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == .Next {
            
            switch textField {
                
            case nameField: titleField.becomeFirstResponder()
            case titleField: emailField.becomeFirstResponder()
            case emailField: twitterField.becomeFirstResponder()
            case twitterField: websiteField.becomeFirstResponder()
            case websiteField: linkedinField.becomeFirstResponder()
            case linkedinField: resumeField.becomeFirstResponder()
            case resumeField: phoneNumberField.becomeFirstResponder()
            case phoneNumberField: companyField.becomeFirstResponder()
            default: break
                
            }
        } else {
            textField.resignFirstResponder()
        }
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
    
    //Method that dismisses the keyboard.
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: Button click method
    @IBAction func makeCard(sender: AnyObject) {
        
        //Check if the user's device has Passbook.
        if PKPassLibrary.isPassLibraryAvailable() {
            
            //These are the minimum requirements for generating a card.
            if nameField.text != "" && titleField.text != "" && emailField.text != "" && phoneNumberField.text != "" {
                
                //Store the user values into an array
                var values = ["Name": "\(nameField.text)", "Title": "\(titleField.text)", "Email": "\(emailField.text)", "Phone": "\(phoneNumberField.text)", "Company": "\(companyField.text)", "Twitter": "\(twitterField.text)","Resume": "\(resumeField.text)", "Linkedin": "\(linkedinField.text)", "Website": "\(websiteField.text)"]
                
                //set the image to be displayed on the card.
                let image = PSImage(named: "Profile", ofType: .Thumbnail)
                image.setImage(photo, forResolution: .High)
                
                let imageArray = [image]
                
                //Show the loading indicator in the middle of the view.
                SwiftLoader.show(title: "Creating your card...", animated: true)
                
                //Create the pass and stop the loading indicator when finished.
                PassSlot.createPassFromTemplateWithName("Business Card Template", withValues: values, withImages: imageArray, andRequestInstallation: self, completion: { SwiftLoader.hide() })
                
            } else {
                //If the requirements are not met, show the user an alert dialog.
                showAlert("Hey, not so fast.", message: "You need to at least have your name, company, title, email address, phone number, and a photo in order to generate a card. Everything else is optional.")
            }
            
        } else {
            //If the user doesn't have Passbook, we show them this:
            showAlert("Bad News", message: "You don't have Passbook on your device, so you can't use this app. Sorry.")
        }
    }
    
    //MARK: Image upload
    @IBAction func uploadImage(sender: UITapGestureRecognizer) {
        photoHelper = PhotoHelper(viewController: self) { (image: UIImage?) in
            self.imageView.image = image
            self.photo = image
        }
    }
}