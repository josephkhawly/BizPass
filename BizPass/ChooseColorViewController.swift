//
//  ChooseColorViewController.swift
//  BizPass
//
//  Created by Joseph Khawly on 7/28/15.
//  Copyright (c) 2015 Joseph Khawly. All rights reserved.
//

import UIKit
import RGBColorSlider

class ChooseColorViewController: UIViewController, RGBColorSliderDataOutlet {

    @IBOutlet var okButton: UIButton!
    
    var defaultRed: Float = 192.0 / 255.0
    var defaultGreen: Float = 57.0 / 255.0
    var defaultBlue: Float = 43.0 / 255.0
    
    var redSlider: RGBColorSlider!
    var greenSlider: RGBColorSlider!
    var blueSlider: RGBColorSlider!
    
    let delegate = RGBColorSliderDelegate()
    
    //FIXME:
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set the delegate for the sliders
        delegate.delegate = self
        
        //Create the sliders.
        redSlider = RGBColorSlider(frame: CGRectMake(20, 140, 280, 44), sliderColor: RGBColorTypeRed, trackHeight: 6, delegate: delegate)
        greenSlider = RGBColorSlider(frame: CGRectMake(20, 188, 280, 44), sliderColor: RGBColorTypeGreen, trackHeight: 6, delegate: delegate)
        blueSlider = RGBColorSlider(frame: CGRectMake(20, 232, 280, 44), sliderColor: RGBColorTypeBlue, trackHeight: 6, delegate: delegate)
        
        //Set the slider values to that of the default app color.
        redSlider!.setValue(defaultRed, animated: true)
        greenSlider!.setValue(defaultGreen, animated: true)
        blueSlider!.setValue(defaultBlue, animated: true)
        
        okButton.layer.cornerRadius = 6
        
        //Add the sliders to the view.
        self.view.addSubview(redSlider!)
        self.view.addSubview(greenSlider!)
        self.view.addSubview(blueSlider!)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    //Update the background color and get the values from each slider.
    func updateColor(color: UIColor!) {
        self.view.backgroundColor = color
        defaultRed = delegate.getRedColorComponent()
        defaultGreen = delegate.getGreenColorComponent()
        defaultBlue = delegate.getBlueColorComponent()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Set the background color of the main view controller to the user's selection.
        if segue.identifier == "back" {
            var viewController = segue.destinationViewController as! ViewController
            viewController.view.backgroundColor = self.view.backgroundColor
        }
    }
}
