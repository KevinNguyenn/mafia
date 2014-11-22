//
//  SelectPlayersViewController.m
//  Mafia
//
//  Created by Moises Holguin on 10/21/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SelectPlayersViewController.h"
#import "CardsViewController.h"
#import "AppDelegate.h"

@interface SelectPlayersViewController () {
    // Holds the number of players
    NSArray *pickerData;
    
    NSDictionary *cardSpecs, *labelSpecs;
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
    
    // set default picker
    NSInteger selectedRow = [self.pickerPlayers selectedRowInComponent:0];
    [[NSUserDefaults standardUserDefaults] setInteger:selectedRow forKey:@"picker"];
    
    
}

-(void)viewWillAppear: (BOOL) animated {
    // notification is not active upon first opening of app because the observer has not been set up
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
    NSUserDefaults *pickerViewSelectionDefaults = [NSUserDefaults standardUserDefaults];
    [self.pickerPlayers selectRow:[pickerViewSelectionDefaults integerForKey:@"picker"] inComponent:0 animated:YES];
    if([self.pickerPlayers selectedRowInComponent:0] == 0) {
        // Scale #: 1
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"139"}, @"card1",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"139"}, @"card2",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"139"}, @"card3",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"288"}, @"card4",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"288"}, @"card5",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"288"}, @"card6", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"90"} , @"labelType1",
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"45"} , @"deathLabel",
                      nil];
    }
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
//    NSLog(@"num players selected: %d",row);
    // 6 players
    // nil means sentinel value
    //!!!!!!!!!!!
    if(row == 0) {
        // SHOULD NOT REACH HERE BECAUSE SET DEFAULT ON TOP OF FILE
        NSLog(@"should not reach here?");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"139"}, @"card1",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"139"}, @"card2",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"139"}, @"card3",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"288"}, @"card4",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"288"}, @"card5",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"288"}, @"card6", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"90"} , @"labelType1",
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"45"} , @"deathLabel",
                      nil];
    }
    //!!!!!!!!!
    // Scale #: 1
    // 7 players
    else if(row == 1) {
//        NSLog(@"7 players");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"121"}, @"card1",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"121"}, @"card2",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"121"}, @"card3",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"16", @"yCoord": @"258"}, @"card4",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"258"}, @"card5",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"228", @"yCoord": @"258"}, @"card6",
                     @{@"cardWidth": @"75", @"cardHeight": @"112", @"xCoord": @"123", @"yCoord": @"388"}, @"card7", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"90"} , @"labelType1",
                      @{@"labelWidth": @"75", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"45"} , @"deathLabel",
                      nil];
    }
    // Scale #: 2
    // 8 players
    else if(row == 2) {
//        NSLog(@"8 players");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"27", @"yCoord": @"118"}, @"card1",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"128", @"yCoord": @"118"}, @"card2",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"228", @"yCoord": @"118"}, @"card3",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"27", @"yCoord": @"249"}, @"card4",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"128", @"yCoord": @"249"}, @"card5",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"228", @"yCoord": @"249"}, @"card6",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"77", @"yCoord": @"380"}, @"card7",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"186", @"yCoord": @"380"}, @"card8", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @{@"labelWidth": @"65", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"79"} , @"labelType1",
                      @{@"labelWidth": @"65", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"40"} , @"deathLabel",
                      nil];
    }
    // Scale #: 2
    // 9 players
    else if(row == 3) {
//        NSLog(@"9 players");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"27", @"yCoord": @"118"}, @"card1",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"128", @"yCoord": @"118"}, @"card2",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"228", @"yCoord": @"118",}, @"card3",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"27", @"yCoord": @"249"}, @"card4",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"128", @"yCoord": @"249"}, @"card5",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"228", @"yCoord": @"249"}, @"card6",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"27", @"yCoord": @"380"}, @"card7",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"128", @"yCoord": @"380"}, @"card8",
                     @{@"cardWidth": @"65", @"cardHeight": @"102", @"xCoord": @"228", @"yCoord": @"380"}, @"card9", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @{@"labelWidth": @"65", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"79"} , @"labelType1",
                      @{@"labelWidth": @"65", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"40"} , @"deathLabel",
                      nil];
    }
    // Scale #: 3
    // 10 players
    else if(row == 4) {
//        NSLog(@"10 players");
        cardSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"47", @"yCoord": @"121"}, @"card1",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"136", @"yCoord": @"121"}, @"card2",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"225", @"yCoord": @"121"}, @"card3",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"47", @"yCoord": @"218"}, @"card4",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"136", @"yCoord": @"218"}, @"card5",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"225", @"yCoord": @"218"}, @"card6",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"47", @"yCoord": @"313"}, @"card7",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"136", @"yCoord": @"313"}, @"card8",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"225", @"yCoord": @"313"}, @"card9",
                     @{@"cardWidth": @"58", @"cardHeight": @"80", @"xCoord": @"136", @"yCoord": @"409"}, @"card10", nil];
        labelSpecs = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @{@"labelWidth": @"58", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"60"} , @"labelType2",
                     @{@"labelWidth": @"58", @"labelHeight": @"20", @"xCoord": @"0", @"yCoord": @"30"} , @"deathLabel2",
                      nil];
    }
    else {
        NSLog(@"wat something went wrong");
    }


    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString: @"goToCards"]) {
//        NSLog(@"about to go to cards");
        [segue.destinationViewController setupCards : cardSpecs AndLabels: labelSpecs AndUpdate : NO ];
    }
}


@end
