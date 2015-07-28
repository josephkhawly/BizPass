//
//  ViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/9/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//
import UIKit
import AlertKit
import ReachabilitySwift
import ALCameraViewController

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - IBOutlets and variables
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
    
    //FIXME: Think about making this a weak reference.
    var photo: UIImage?
    
    //MARK: - viewDidLoad Method
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
        imageTapGesture.delegate = self
        
        let dismissGesture = UIGestureRecognizer(target: self, action: Selector("dismissKeyboard:"))
        self.view.addGestureRecognizer(dismissGesture)
        dismissGesture.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //photo = nil
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    //Prevent tap gestures from interfering with the button.
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer.isMemberOfClass(UITapGestureRecognizer) {
            if touch.view.isKindOfClass(UIButton) {
                return true
            }
        }
        return false
    }
    
    //MARK: - Keyboard management
    /*func textFieldDidBeginEditing(textField: UITextField) {
        //Hide the imageView and move textFields up so the keyboard doesn't hide them
        if textField == linkedinField || textField == resumeField {
            //imageView.hidden = true
            animateViewMoving(true, moveValue: 160)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //Do the opposite when done editing.
        if textField == linkedinField || textField == resumeField {
            //imageView.hidden = false
            animateViewMoving(false, moveValue: 160)
        }
    }*/
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == .Next {
            
            switch textField {
                
            case nameField: companyField.becomeFirstResponder()
            case companyField: titleField.becomeFirstResponder()
            case titleField: phoneNumberField.becomeFirstResponder()
            case phoneNumberField: emailField.becomeFirstResponder()
            case emailField: websiteField.becomeFirstResponder()
            case websiteField: twitterField.becomeFirstResponder()
            case twitterField: linkedinField.becomeFirstResponder()
            case linkedinField: resumeField.becomeFirstResponder()
            default: break
                
            }
            
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    /*func animateViewMoving(up: Bool, moveValue: CGFloat) {
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }*/
    
    //Method that dismisses the keyboard.
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Button click method
    @IBAction func makeCard(sender: AnyObject) {
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Make sure there is an internet connection before creating the card.
        if reachability.isReachable() {
            
            //These are the minimum requirements for generating a card.
            if nameField.text != "" && titleField.text != "" && emailField.text != "" && phoneNumberField.text != "" && photo != nil {
                
                //Store the user values into an array
                var values = ["Name": "\(nameField.text)", "Title": "\(titleField.text)", "Email": "\(emailField.text)", "Phone": "\(phoneNumberField.text)", "Company": "\(companyField.text)", "Twitter": "\(twitterField.text)","Resume": "\(resumeField.text)", "Linkedin": "\(linkedinField.text)", "Website": "\(websiteField.text)"]
                
                for (field, content) in values {
                    if values[field] == "" { values.updateValue("N/A", forKey: field) }
                }
                
                //Make the card.
                PassHelper(values: values, profile: photo!, viewController: self)
                
            } else {
                //If the requirements are not met, show the user an alert dialog.
                showAlert("Hey, not so fast there.", message: "You need to at least have your name, email address, title, company name, phone number, and a photo in order to generate a card. Everything else is optional.")
            }
            
        } else {
            showAlert("Error", message: "You must be connected to the internet in order to make your card.")
        }
    }
    
    //MARK: - Image upload
    @IBAction func uploadImage(sender: UITapGestureRecognizer) {
        //Open the image selector and cropper, set the images, and close when done.
        let cameraViewController = ALCameraViewController(croppingEnabled: true) { image in
            self.imageView.image = image
            self.photo = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
}