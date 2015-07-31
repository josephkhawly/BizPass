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
import AKPickerView_Swift

class ViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource {
    
    //MARK: - IBOutlets and variables
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    
    @IBOutlet weak var row2Height: NSLayoutConstraint!
    @IBOutlet weak var row3Height: NSLayoutConstraint!
    @IBOutlet weak var row4Height: NSLayoutConstraint!
    
    @IBOutlet weak var picker: AKPickerView!
    
    var photo: UIImage?
    var deviceModel = UIDevice.currentDevice().model
    let colors = ["Green", "Orange", "Blue", "Red", "Purple", "Brown"]
    
    //MARK: - view settings
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setNeedsUpdateConstraints()
        
        self.nameField.delegate = self
        self.companyField.delegate = self
        self.titleField.delegate = self
        self.emailField.delegate = self
        self.phoneNumberField.delegate = self
        self.websiteField.delegate = self
        self.twitterField.delegate = self
        self.linkedinField.delegate = self
        self.resumeField.delegate = self
        
        //Add the tap gestures
        let imageTapGesture = UIGestureRecognizer(target: self, action: Selector("uploadImage:"))
        imageView.addGestureRecognizer(imageTapGesture)
        imageTapGesture.delegate = self
        
        let dismissGesture = UIGestureRecognizer(target: self, action: Selector("dismissKeyboard:"))
        self.view.addGestureRecognizer(dismissGesture)
        dismissGesture.delegate = self
        
        //Configure picker view
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.font = UIFont(name: "SFUIDisplay-Light", size: 20)!
        self.picker.highlightedFont = UIFont(name: "SFUIDisplay-Regular", size: 20)!
        self.picker.interitemSpacing = 20.0
        self.picker.textColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //photo = nil
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if UIScreen.mainScreen().bounds.size.height == 480.0 {
            self.row2Height.constant = 12
            self.row3Height.constant = 12
            self.row4Height.constant = 12
        } else if UIScreen.mainScreen().bounds.size.height == 568.0 {
            self.row2Height.constant = 35
            self.row3Height.constant = 35
            self.row4Height.constant = 35
        } else if UIScreen.mainScreen().bounds.size.height == 667.0 || UIScreen.mainScreen().bounds.size.height == 736.0 {
            self.row2Height.constant = 55
            self.row3Height.constant = 55
            self.row4Height.constant = 55
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) { view.endEditing(true) }
    
    //MARK: - Button click method
    @IBAction func makeCard(sender: AnyObject) {
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Make sure there is an internet connection before creating the card.
        if reachability.isReachable() {
            
            //These requirements must be met in order to generate a card.
            if nameField.text != "" && companyField.text != "" && titleField.text != "" && emailField.text != "" && phoneNumberField.text != "" && photo != nil {
                
                //Store the user values into an array
                var values = ["Name": "\(nameField.text)", "Title": "\(titleField.text)", "Email": "\(emailField.text)", "Phone": "\(phoneNumberField.text)", "Company": "\(companyField.text)", "Website": "\(websiteField.text)", "Twitter": "\(twitterField.text)", "Linkedin": "\(linkedinField.text)", "Resume": "\(resumeField.text)", "backgroundColor": "rgb(22,179,85)"]
                
                for (field, input) in values {
                    if values[field] == "" { values[field] == "N/A" }
                }
                
                //Make the card.
                PassHelper(values: values, profile: photo!, viewController: self)
                
            } else {
                showAlert("Hey, not so fast there.", message: "You must have all fields with a * filled in as well as a photo. Everything else is optional.")
            }
            
        } else {
            showAlert("Error", message: "You must be connected to the internet in order to make your card.")
        }
    }
    
    //MARK: - Image upload
    @IBAction func uploadImage(sender: UITapGestureRecognizer) {
        //Open the image selector and cropper, set the images, and close when done.
        let cameraViewController = ALCameraViewController(croppingEnabled: true) { image in
            
            if image != nil {
                self.imageView.image = image
                self.photo = image
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    //MARK: - Picker methods
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int { return self.colors.count }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String { return self.colors[item] }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        switch item {
            case 0: self.view.backgroundColor = UIColor(red: 22/255, green: 179/255, blue: 85/255, alpha: 1.0)
            
            default: break
        }
    }
}

//MARK: - Keyboard management
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .Next {
            
            switch textField {
                case nameField: companyField.becomeFirstResponder()
                case companyField: titleField.becomeFirstResponder()
                case titleField: emailField.becomeFirstResponder()
                case emailField: phoneNumberField.becomeFirstResponder()
                case phoneNumberField: websiteField.becomeFirstResponder()
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
}

//MARK: - Gesture methods
extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if gestureRecognizer.isMemberOfClass(UITapGestureRecognizer) {
            
            if touch.view.isKindOfClass(UIButton) { return true }
            
        }
        return false
    }
}