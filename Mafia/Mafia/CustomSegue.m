//
//  CustomSegue.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CustomSegue.h"
#import "SingleCardViewController.h"
#import "CardsViewController.h"
#import "SingleCardPlayerViewController.h"

@implementation CustomSegue

- (void)perform {

    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    // Transformation start scale
    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    // Store original centre point of the destination view
    CGPoint originalCenter = destinationViewController.view.center;
    
    // Set center to start point of the button
    destinationViewController.view.center = self.originatingPoint;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!
                         destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         destinationViewController.view.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         // present VC
                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL];
                         
                         
                         // change the button here
                         // and show roles
                         if([(CardsViewController *)sourceViewController getSwitchStatus] == YES) {
                             NSLog(@"do the kill from custom segue");
                             [(SingleCardViewController *)destinationViewController displayKillButton:@"Kill"];
                             NSArray *childVCArray = ((SingleCardViewController *)destinationViewController).childViewControllers;
                             // temp variable for iteration
                             UIViewController *vc;
                             // get the VC for the inner view controller
                             UIViewController *s2;
                             for(vc in childVCArray) {
                                 if([vc.title isEqualToString:@"SingleCard2 View Controller"]) {
                                     NSLog(@"found the view controller SingleCard2");
                                     s2 = vc;
                                 }
                             }
                             // change from uitextfield to uilabel with the name
                             [(SingleCardPlayerViewController *)s2 modifyTextField : self.card.name];
                             [(SingleCardPlayerViewController *)s2 showRole : self.card.role];
                         }
                         else {
                             NSLog(@"do the save from custom segue");
                             [(SingleCardViewController *)destinationViewController displaySaveButton:@"Save"];
                             NSArray *childVCArray = ((SingleCardViewController *)destinationViewController).childViewControllers;
                             // temp variable for iteration
                             UIViewController *vc;
                             // get the VC for the inner view controller
                             UIViewController *s2;
                             for(vc in childVCArray) {
                                 if([vc.title isEqualToString:@"SingleCard2 View Controller"]) {
                                     NSLog(@"found the view controller SingleCard2");
                                     s2 = vc;
                                 }
                             }
                             [(SingleCardPlayerViewController *)s2 showRole : self.card.role];
                         }
                         
                     }
     ];
    


    
    
}

@end
