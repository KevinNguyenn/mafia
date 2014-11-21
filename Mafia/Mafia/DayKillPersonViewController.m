//
//  DayKillPersonViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/10/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "DayKillPersonViewController.h"
#import "CardsViewController.h"

@interface DayKillPersonViewController ()

@end

@implementation DayKillPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString: @"killPersonDaySegue"]) {
        [segue.destinationViewController updatePlayButton : @"Continue Day Time" AndCanTouchCard : YES];
    }
}


@end
