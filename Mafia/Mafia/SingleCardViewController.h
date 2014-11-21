//
//  SingleCardViewController.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCard.h"


@interface SingleCardViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIButton *exitButton;
//the button
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

// methods to modify text of action button
-(void) displayKillButton : (NSString *) theKill;
-(void) displaySaveButton : (NSString *) theSave;


@end
