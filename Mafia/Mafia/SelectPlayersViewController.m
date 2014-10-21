//
//  SelectPlayersViewController.m
//  Mafia
//
//  Created by Moises Holguin on 10/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SelectPlayersViewController.h"

@interface SelectPlayersViewController () {
    // Holds the number of players
    NSArray *pickerData;
}
@end

@implementation SelectPlayersViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set options for number of players
    pickerData = @[@"6", @"7", @"8", @"9", @"10"];
    
    // Connect data to picker
    self.pickerPlayers.dataSource = self;
    self.pickerPlayers.delegate = self;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
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
