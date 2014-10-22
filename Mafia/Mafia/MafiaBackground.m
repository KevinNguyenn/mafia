//
//  MafiaBackground.m
//  Mafia
//
//  Created by Fang Tang on 10/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "MafiaBackground.h"

@interface MafiaBackground ()

@end

@implementation MafiaBackground

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *backgroundImage = [UIImage imageNamed:@"mafia.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    
    [self.view insertSubview:backgroundImageView atIndex:0];
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

@end
