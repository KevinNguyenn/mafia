//
//  SingleCardViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCardViewController.h"
#import "CardsViewController.h"
#import "SingleCardPlayerViewController.h"


@interface SingleCardViewController ()

@property (nonatomic, strong) NSString *tempString;

@end

@implementation SingleCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(gatherNameOfCard:) name:@"gatherNameOfCard" object:nil];
  
    
//    [self.exitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    //Commented out for now
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [self.view addGestureRecognizer:singleTap];
//    singleTap.numberOfTapsRequired = 1;
//    singleTap.numberOfTouchesRequired = 1;
    
    
//    [self displaySaveButton];
    NSLog(@"view did load on single card view controller...");
    NSLog(@"%@", [self.actionButton class]);
    NSLog(@"%@", [self.exitButton class]);
    NSLog(@"%@", self.actionButton.titleLabel.text);

    [self.actionButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
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


//
//-(void) handleSingleTap:(UITapGestureRecognizer *)gr {
//    // Use or nah???
//    NSLog(@"use or nah");
//}




-(void) displayKillButton : (NSString *) theKill {
//    NSLog(@"%@", [cardView class]);
    NSLog(@"change to kill");
//    NSArray *childVCArray = self.childViewControllers;
//    UIViewController *vc;
//    UIViewController *s2;
//    for(vc in childVCArray) {
//        if([vc.title isEqualToString:@"SingleCard2 View Controller"]) {
//            NSLog(@"found the view controller");
//            s2 = vc;
//        }
//    }
//    // change from uitextfield to uilabel with the name
//    [(SingleCardPlayerViewController *)s2 modifyTextField : cardView.name];
    [self.actionButton setTitle: theKill forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
}

-(void) displaySaveButton : (NSString *) theSave {
    NSLog(@"change to save");
    [self.actionButton setTitle: theSave forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void) gatherNameOfCard : (NSNotification *) dict {
    NSDictionary *theName = [dict userInfo];
    NSString *name = [theName objectForKey: @"playerName"];
    self.tempString = name;
    NSLog(@"put name into temp string");
}

- (void)saveName:(UIButton *)sender {
    if(self.tempString != NULL && ![self.tempString isEqualToString:@""]) {
        NSDictionary *theName = @{@"playerName": self.tempString};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNameOfCard" object:nil userInfo:theName];
        
        [NSThread sleepForTimeInterval:1.0f];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.notificationLabel setText:@"Name Saved."];
        });
    }

}

- (void)killPlayer:(UIButton *)sender {
    if(self.tempString != NULL && ![self.tempString isEqualToString:@""]) {
        NSDictionary *theName = @{@"playerName": self.tempString};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KillPlayer" object:nil userInfo:theName];
    
        [NSThread sleepForTimeInterval:1.0f];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.notificationLabel setText:@"Player Killed."];
        });
    }
}


-(IBAction)btnClicked: (UIButton *)sender {
    if ([self.actionButton.titleLabel.text isEqualToString: @"Save"]) {
        [self saveName:sender];
    }
    else if ([self.actionButton.titleLabel.text isEqualToString: @"Kill"]){
        [self killPlayer:sender];
    }
}



@end
