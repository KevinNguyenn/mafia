//
//  NightKillPersonViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/9/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "NightKillPersonViewController.h"
#import "CardsViewController.h"

@interface NightKillPersonViewController ()

@end

@implementation NightKillPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
     if([segue.identifier isEqualToString: @"killPersonNightSegue"]) {
         [segue.destinationViewController updatePlayButton : @"Enter Day Time"];
     }
}


@end
