//
//  CardsNavigationViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/14/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CardsNavigationViewController.h"
#import "CardsViewController.h"
#import "CustomUnwindSegue.h"

@interface CardsNavigationViewController ()

@end

@implementation CardsNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// HACKY, have to establish this unwind segue method in the navigation controller...
// We need to over-ride this method from UIViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    CustomUnwindSegue *segue = [[CustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point for the animation to the center of the button in this VC
    segue.targetPoint = [(CardsViewController*)toViewController getViewCenter];
    return segue;
}

@end
