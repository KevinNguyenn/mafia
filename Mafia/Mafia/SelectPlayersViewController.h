//
//  SelectPlayersViewController.h
//  Mafia
//
//  Created by Moises Holguin on 10/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPlayersViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerPlayers;

@end
