//
//  SelectPlayersViewController.m
//  Mafia
//
//  Created by Moises Holguin on 10/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SelectPlayersViewController.h"
#import "CardsViewController.h"

@interface SelectPlayersViewController () {
    // Holds the number of players
    NSArray *pickerData;
    
    NSDictionary *cardSpecs;
}
@end

@implementation SelectPlayersViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set options for number of players
    // potential to add more?
    pickerData = @[@"6", @"7", @"8", @"9", @"10"];
    
    // Connect data to picker
    self.pickerPlayers.dataSource = self;
    self.pickerPlayers.delegate = self;
    NSLog(@"EBOLA");
    
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

// [DYNAMIC ACTION] to setup the number of cards based on the number of players
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"num players selected: %d",row);
    // 6 players
    if(row == 0) {
        NSLog(@"nigga bitcH");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"62"}, @"card1",
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"62"}, @"card2",
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"62"}, @"card3",
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"211"}, @"card4",
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"211"}, @"card5",
                              @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"211"}, @"card6", nil];
    }
    // 7 players
    else if(row == 1) {
        NSLog(@"7 players");
    }
    // 8 players
    else if(row == 2) {
        NSLog(@"8 players");
    }
    // 9 players
    else if(row == 3) {
        NSLog(@"9 players");
    }
    // 10 players
    else if(row == 4) {
        NSLog(@"10 players");
    }
    else {
        NSLog(@"wat");
    }


    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString: @"goToCards"]) {
        NSLog(@"going to cards");
//         NSLog(@"Dictionary: %@", [cardSpecs description]);
        [segue.destinationViewController setupCards : cardSpecs];
    }
}


@end
