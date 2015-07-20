//
//  UIViewController+FTIAutomaticKeyboardAdjustment.h
//  FTIAutomaticKeyboardAdjustment
//
//  Created by Brendan Lee on 6/22/15.
//  Copyright (c) 2015 Brendan Lee. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIViewController (FTIAutomaticKeyboardAdjustment)

/**
 *  A simple convenience method for closing the keyboard from Interface Builder.
 *
 *  @param sender Any object making the request. Can be nil.
 */
- (IBAction)endEditingOnView:(id)sender;

@end
