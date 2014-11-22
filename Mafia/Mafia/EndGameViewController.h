//
//  EndGameViewController.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

-(void) showTeam : (NSString *) theTeam;

@end
