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
@property (nonatomic, weak) SingleCard *theCard;

@end

@implementation SingleCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(gatherNameOfCard:) name:@"gatherNameOfCard" object:nil];

    [self.actionButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.exitButton.enabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) displayKillButton : (NSString *) theKill {
    [self.notificationLabel setText:@"Player not killed."];
    [self.actionButton setTitle: theKill forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void) displaySaveButton : (NSString *) theSave {
    [self.notificationLabel setText:@"Name not saved."];
    [self.actionButton setTitle: theSave forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

// Get the name from UITextField from the inner View Controller
-(void) gatherNameOfCard : (NSNotification *) dict {
    NSDictionary *theName = [dict userInfo];
    NSString *name = [theName objectForKey: @"playerName"];
    self.tempString = name;
    NSLog(@"put name into temp string");
}




// Dynamic method actionButton defined in viewDidLoad
-(IBAction) btnClicked: (UIButton *)sender {
    NSLog(@"%@", self.actionButton.titleLabel.text);
    if ([self.actionButton.titleLabel.text isEqualToString: @"Save"]) {
        [self saveName:sender];
        NSLog(@"SaveName");
    }
    else if ([self.actionButton.titleLabel.text isEqualToString: @"Kill"]){
        [self killPlayer:sender];
        NSLog(@"KillPlayer");
    }
}

-(void)saveName:(UIButton *)sender {
    if(self.tempString != NULL && ![self.tempString isEqualToString:@""]) {
        NSDictionary *theName = @{@"playerName": self.tempString};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNameOfCard" object:nil userInfo:theName];
        [NSThread sleepForTimeInterval:1.0f];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.notificationLabel setText:@"Name saved."];
        });
        self.exitButton.enabled = YES;
    }

}

-(void)killPlayer:(UIButton *)sender {
    NSLog(@"KillButton");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KillPlayer" object:nil ];
    [NSThread sleepForTimeInterval:1.0f];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.notificationLabel setText:@"Player killed."];
    });
    self.exitButton.enabled = YES;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
 }
 */
 

@end
