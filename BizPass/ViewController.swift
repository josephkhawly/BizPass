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
     */

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var webstieField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    @IBOutlet weak var resumeField: UITextField!
    @IBOutlet weak var githubField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PKPassLibrary.isPassLibraryAvailable() {
            PassSlot.start("oalzIWdtIUZdOmQaaCtSQnRYzrHpFjSLeiLjBXiLlzMLOPLFmeoYYmvUljKyMacX")
            
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


