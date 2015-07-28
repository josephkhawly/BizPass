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

    override func viewDidLoad() {
        super.viewDidLoad()

        let delegate = RGBColorSliderDelegate()
        delegate.delegate = self
        
        let redSlider = RGBColorSlider(frame: CGRectMake(20, 140, 280, 44), sliderColor: RGBColorTypeRed, trackHeight: 6, delegate: delegate)
        let greenSlider = RGBColorSlider(frame: CGRectMake(20, 188, 280, 44), sliderColor: RGBColorTypeGreen, trackHeight: 6, delegate: delegate)
        let blueSlider = RGBColorSlider(frame: CGRectMake(20, 232, 280, 44), sliderColor: RGBColorTypeBlue, trackHeight: 6, delegate: delegate)
        
        
        
        self.view.addSubview(redSlider)
        self.view.addSubview(greenSlider)
        self.view.addSubview(blueSlider)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    func updateColor(color: UIColor!) {
        self.view.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
