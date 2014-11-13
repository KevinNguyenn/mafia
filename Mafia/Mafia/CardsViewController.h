//
//  CardsViewController.h
//  Mafia
//
//  Created by Kevin Nguyen on 10/28/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardsViewController : UIViewController

-(void) setupCards : (NSDictionary *) cardSpecs AndUpdate : (BOOL) update;
-(void) updatePlayButton : (NSString *) text;

@property (weak, nonatomic) IBOutlet UIButton *beginNightButton;
@property (weak, nonatomic) IBOutlet UIButton *beginDayButton;
@property (weak, nonatomic) IBOutlet UIButton *continueDayButton;
@property (weak, nonatomic) IBOutlet UISwitch *deathSwitch;
@property (weak, nonatomic) IBOutlet UILabel *deathSwitchLabel;


@property BOOL didSetupCards;


- (void)refreshCards;


@end
