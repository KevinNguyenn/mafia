//
//  SingleCardViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCardViewController.h"


@interface SingleCardViewController ()


@end

@implementation SingleCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Something here");
    
    //Commented out for now
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [self.view addGestureRecognizer:singleTap];
//    singleTap.numberOfTapsRequired = 1;
//    singleTap.numberOfTouchesRequired = 1;
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

-(void) handleSingleTap:(UITapGestureRecognizer *)gr {
    // Use or nah???
    
}



@end
