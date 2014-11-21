//
//  SingleCardPlayerViewController.h
//  Mafia
//
//  Created by Kevin Nguyen on 11/20/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCardViewController.h"


@interface SingleCardPlayerViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

-(void) modifyTextField : (NSString *) name;
-(void) showRole : (NSInteger) roleNum;

@end
