//
//  UIViewController+FTIAutomaticKeyboardAdjustment.h
//  FTIAutomaticKeyboardAdjustment
//
//  Created by Brendan Lee on 6/22/15.
//  Copyright (c) 2015 Brendan Lee. All rights reserved.
//

#import "UIViewController+FTIAutomaticKeyboardAdjustment.h"
#import <objc/runtime.h>

static void *FTIAutomaticKeyboardAdjustmentKey;

@implementation UIViewController (FTIAutomaticKeyboardAdjustment)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self fti_swizzleAppear];
        [self fti_swizzleDisappear];
    });
}

+(void)fti_swizzleAppear
{
    Class class = [self class];
    
    SEL originalSelector = @selector(viewDidAppear:);
    SEL swizzledSelector = @selector(fti_viewDidAppear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+(void)fti_swizzleDisappear
{
    Class class = [self class];
    
    SEL originalSelector = @selector(viewDidDisappear:);
    SEL swizzledSelector = @selector(fti_viewDidDisappear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)fti_viewDidAppear:(BOOL)animated {
    [self fti_viewDidAppear:animated]; //Call the class's real implementation

    //Don't modify UIKit classes.
    if ([NSStringFromClass([self class]).lowercaseString rangeOfString:@"ui"].location == 0 ||
        [NSStringFromClass([self class]).lowercaseString rangeOfString:@"_ui"].location == 0) {
        return;
    }
    
    //If not a root UIKit class, go ahead and allow it.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fti_keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)fti_viewDidDisappear:(BOOL)animated {
    [self fti_viewDidDisappear:animated]; //Call the class's real implementation
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fti_keyboardWillChangeFrame:(NSNotification *)sender {
    
    NSMutableArray *constraintsToModify = [self constraintsSupportingModification];
    
    if (constraintsToModify.count > 0) {
    
        CGRect frame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect keyboardFrameInViewCoordinates = [self.view convertRect:frame fromView:nil];
        
        CGFloat constantModification = CGRectGetHeight(self.view.bounds) - keyboardFrameInViewCoordinates.origin.y;
        
        NSMutableDictionary *previousConstraintValues = [self originalConstraintValues];
        
        for (NSLayoutConstraint *constraint in constraintsToModify.copy) {
    
            NSNumber *previousConstant = previousConstraintValues[[NSString stringWithFormat:@"%p",constraint]];
            
            if (!previousConstant) {
                previousConstraintValues[[NSString stringWithFormat:@"%p",constraint]] = @(constraint.constant);
                previousConstant = @(constraint.constant);
            }
            
            constraint.constant = (CGFloat)previousConstant.floatValue + constantModification;
        }
        
        //When the keyboard closes clear the constraint cache so they can be modified and re-cached next time.
        if (constantModification < 1.0) {
            [previousConstraintValues removeAllObjects];
        }
        
        [self.view layoutIfNeeded];
    }
}

-(NSMutableArray*)constraintsSupportingModification
{
    NSMutableArray *constraintsToModify = [NSMutableArray array];
    
    for (NSLayoutConstraint *constraint in self.view.constraints.copy) {
        if (constraint.relation == NSLayoutRelationEqual) {
            
            if ([self isItemViewOrLayoutGuide:constraint.firstItem] &&
                constraint.secondAttribute == NSLayoutAttributeBottom &&
                [self isItemSubviewOfMainView:constraint.secondItem]) {
                
                [constraintsToModify addObject:constraint];
            }
            
            if ([self isItemViewOrLayoutGuide:constraint.secondItem] &&
                constraint.firstAttribute == NSLayoutAttributeBottom &&
                [self isItemSubviewOfMainView:constraint.firstItem]) {
                
                [constraintsToModify addObject:constraint];
            }
        }
    }
    
    return constraintsToModify;
}

-(BOOL)isItemViewOrLayoutGuide:(id)currentItem
{
    if (currentItem == self.view ||
        currentItem == self.bottomLayoutGuide) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isItemSubviewOfMainView:(id)currentItem
{
    if ([currentItem isKindOfClass:[UIView class]] &&
        //Net out some common types constraints that get shoved in.
        [NSStringFromClass([currentItem class]).lowercaseString rangeOfString:@"uilayout"].location == NSNotFound &&
        [NSStringFromClass([currentItem class]).lowercaseString rangeOfString:@"uikey"].location != 0 &&
        [NSStringFromClass([currentItem class]).lowercaseString rangeOfString:@"_uikb"].location != 0 &&
        [NSStringFromClass([currentItem class]).lowercaseString rangeOfString:@"uiinput"].location != 0)
    {
        UIView *currentView = (UIView*)currentItem;
        
        if (currentView.superview == self.view) {
            return YES;
        }
    }
    
    return NO;
}

- (NSMutableDictionary *)originalConstraintValues {
    NSMutableDictionary *result = objc_getAssociatedObject(self, &FTIAutomaticKeyboardAdjustmentKey);
    if (result == nil) {
        result = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &FTIAutomaticKeyboardAdjustmentKey, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (IBAction)endEditingOnView:(id)sender {
    [self.view endEditing:YES];
}
@end
