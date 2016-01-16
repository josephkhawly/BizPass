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
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var picker: AKPickerView!
    
    weak var photo: UIImage?
    var screenHeight = UIScreen.mainScreen().bounds.size.height
    let colors = ["Red", "Green", "Pink", "Orange", "Blue", "Purple", "Gray", "Brown"]
    var colorString: String = ""
    
    //MARK: - View settings
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure constraints
        view.setNeedsUpdateConstraints()
        
        //Configure picker view
        picker.delegate = self
        picker.dataSource = self
        picker.pickerViewStyle = .Wheel
        picker.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Update contraints based on screen height
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if screenHeight == 480.0 {
            
            row2Height.constant = 12
            row3Height.constant = 12
            row4Height.constant = 12
            pickerHeight.constant = 59
            
        } else if screenHeight == 568.0 {
            
            row2Height.constant = 35
            row3Height.constant = 35
            row4Height.constant = 35
            pickerHeight.constant = 83
            
        } else if screenHeight == 667.0 || screenHeight == 736.0 {
            
            row2Height.constant = 55
            row3Height.constant = 55
            row4Height.constant = 55
            pickerHeight.constant = 100
            
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    //MARK: - Picker methods
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int { return self.colors.count }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String { return self.colors[item] }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        
        //Color selction
        switch item {
            
        case 0:
            view.backgroundColor = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1.0)
            colorString = colors[0]
        case 1:
            view.backgroundColor = UIColor(red: 22/255, green: 179/255, blue: 85/255, alpha: 1.0)
            colorString = colors[1]
        case 2:
            view.backgroundColor = UIColor(red: 215/255, green: 125/255, blue: 169/255, alpha: 1.0)
            colorString = colors[2]
        case 3:
            view.backgroundColor = UIColor(red: 255/255, green: 124/255, blue: 0/255, alpha: 1.0)
            colorString = colors[3]
        case 4:
            view.backgroundColor = UIColor(red: 61.4/255, green: 171.8/255, blue: 255.0/255, alpha: 1.0)
            colorString = colors[4]
        case 5:
            view.backgroundColor = UIColor(red: 123/255, green: 44/255, blue: 213/255, alpha: 1.0)
            colorString = colors[5]
        case 6:
            view.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1.0)
            colorString = colors[6]
        case 7:
            view.backgroundColor = UIColor(red: 122/255, green: 67/255, blue: 0/255, alpha: 1.0)
            colorString = colors[7]
            
        default: break
            
        }
    }
    
    //MARK: - Button click method
    @IBAction func makeCard(sender: AnyObject) {
        //let reachability: Reachability
        do {
            _ = try Reachability.reachabilityForInternetConnection()
            //These requirements must be met in order to generate a card.
            if nameField.text != "" && companyField.text != "" && titleField.text != "" && emailField.text != "" && phoneNumberField.text != "" && photo != nil {
                
                //Store the user values into an array
                var values = ["Name": "\(nameField.text)", "Title": "\(titleField.text)", "Email": "\(emailField.text)", "Phone": "\(phoneNumberField.text)", "Company": "\(companyField.text)", "Website": "\(websiteField.text)", "Twitter": "\(twitterField.text)", "Linkedin": "\(linkedinField.text)", "Resume": "\(resumeField.text)"]
                
                //Put "N/A" in the optional fields if they're not filled in.
                for (field, _) in values {
                    if values[field] == "" { values[field] = "N/A" }
                }
                
                //Make the card.
                PassHelper(values: values, picture: photo!, color: colorString, viewController: self)
                
            } else {
                showAlert("Hey, not so fast there.", message: "All fields with a * must be filled in and you must upload a photo. Everything else is optional.")
            }
        } catch {
            showAlert("Error", message: "You must be connected to the internet in order to make your card.")
            return
        }
        
        
        //Make sure there is an internet connection before creating the card to prevent the app from crashing.
        /*if reachability.isReachable() {
        
        
        
        }*/
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
        return true
    }
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) { view.endEditing(true) }
    
}