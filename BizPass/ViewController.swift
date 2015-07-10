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
     */

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the font for each text field
        nameField.font = UIFont(name: "SF UI Text Light", size: 20)
        titleField.font = UIFont(name: "SF UI Text Light", size: 20)
        emailField.font = UIFont(name: "SF UI Text Light", size: 20)
        companyField.font = UIFont(name: "SF UI Text Light", size: 20)
        facebookField.font = UIFont(name: "SF UI Text Light", size: 20)
        twitterField.font = UIFont(name: "SF UI Text Light", size: 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

