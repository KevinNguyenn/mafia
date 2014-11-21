//
//  SingleCardPlayerViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/20/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCardPlayerViewController.h"
#import "CardsViewController.h"

@interface SingleCardPlayerViewController ()

@end

@implementation SingleCardPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
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
    NSLog(@"gonna go backkkkkkk");
}


// press away from keyboard to dismiss
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    // pass notification back to cards view to update the name
    if(self.nameField.text != NULL && ![self.nameField.text isEqualToString:@""]) {
        NSDictionary *theCard = @{@"playerName": self.nameField.text};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gatherNameOfCard" object:nil userInfo:theCard];
    }
}

// resign the keyboard when done "return button"
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField) {
        [textField resignFirstResponder];
    }
    // pass notification back to cards view to update the name
    if(self.nameField.text != NULL && ![self.nameField.text isEqualToString:@""]) {
        NSDictionary *theName = @{@"playerName": self.nameField.text};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gatherNameOfCard" object:nil userInfo:theName];
    }
    return YES;
}


-(void) modifyTextField : (NSString *) name {
    [self.nameField removeFromSuperview];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(16, 61, 204, 30)];
    [nameLabel setText:name];
    [nameLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 17.0f]];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: nameLabel];
    NSLog(@"show the name");
}

-(void) showRole : (NSInteger) roleNum {
    // 1 - Mafia Role
    // 2 - Police Role
    // 3 - Innocent Role
    
    switch(roleNum) {
        case 1:
            [self.roleLabel setText: @"Mafia"];
            [self.roleLabel setTextColor:[UIColor redColor]];
            break;
        case 2:
            [self.roleLabel setText: @"Police Officer"];
            [self.roleLabel setTextColor:[UIColor blueColor]];
            break;
            
        case 3:
            [self.roleLabel setText: @"Innocent"];
            [self.roleLabel setTextColor:[UIColor greenColor]];
            break;
        default:
            NSLog(@"undefined role. should not reach here.");
            break;
    }

}


@end
