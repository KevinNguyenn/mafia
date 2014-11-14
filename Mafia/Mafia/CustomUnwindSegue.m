//
//  CustomUnwindSegue.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CustomUnwindSegue.h"

@implementation CustomUnwindSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add view to super view temporarily
    [sourceViewController.view.superview insertSubview:destinationViewController.view atIndex:0];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Shrink!
                         sourceViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
                         sourceViewController.view.center = self.targetPoint;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController dismissViewControllerAnimated:NO completion:NULL]; // dismiss VC
                     }];
}

@end
