//
//  OptionalFieldsViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/30/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit

/* This view controller exists for several reasons:
    
    -To separate the optional fields from the required ones.
    -To make the UX emulate that of looking at an actual Passbook pass.
    -Because I can't into TableViews or keyboard management.
*/
class OptionalFieldsViewController: UIViewController {

    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Add the text in the fields to the values dictionary.
        let dest = segue.destinationViewController as! ViewController
        if websiteField.text != "" && twitterField.text != "" && linkedinField.text != "" && resumeField.text != "" {
            dest.values["Website"] = "\(websiteField.text)"
            dest.values["Twitter"] = "\(twitterField.text)"
            dest.values["Linkedin"] = "\(linkedinField.text)"
            dest.values["Resume"] = "\(resumeField.text)"
        }
        
        
    }
}


