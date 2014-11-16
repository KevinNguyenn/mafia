//
//  SingleCardViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/13/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCardViewController.h"
#import "CardsViewController.h"


@interface SingleCardViewController ()


@end

@implementation SingleCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.nameField.delegate = self;
    
//    [self.exitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    //Commented out for now
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [self.view addGestureRecognizer:singleTap];
//    singleTap.numberOfTapsRequired = 1;
//    singleTap.numberOfTouchesRequired = 1;
    
    
    [self displaySaveButton];
    NSLog(@"set observer");

    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(displayKillButton) name:@"KillButtonOn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(displaySaveButton) name:@"SaveButtonOn" object:nil];
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

// press away from keyboard to dismiss
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    
    // pass notification back to cards view to update the name
    NSDictionary *theCard = @{@"playerName": self.nameField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNameOfCard" object:nil userInfo:theCard];
}

// resign the keyboard when done "return button"
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField) {
        [textField resignFirstResponder];
    }
    // pass notification back to cards view to update the name
    NSDictionary *theCard = @{@"playerName" : self.nameField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNameOfCard" object:nil userInfo:theCard];
    return YES;
}

-(void) displayKillButton  {
    NSLog(@"change to kill");
    [self.actionButton setTitle:@"Kill" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}



-(void) displaySaveButton {
    NSLog(@"change to save");
    [self.actionButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}



@end
