//
//  CardsViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 10/28/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CardsViewController.h"
#import "AppDelegate.h"
#import "SingleCardViewController.h"

// Custom segue stuff
#import "CustomSegue.h"
#import "CustomUnwindSegue.h"

// Used to randomize player roles
#import "NSMutableArray_Shuffle.h"



@interface CardsViewController ()

@property (nonatomic, weak) NSString* currentButtonText;
@property (nonatomic, strong) NSMutableArray *cardStorage;
@property (nonatomic, strong) NSMutableArray *playerRoles;
@property (nonatomic, weak) SingleCard *card;
@property CGPoint cardCenter;

@property BOOL isDeathSwitchOn;
@property BOOL canDisableCard;
@property BOOL deathSwitchCase;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardStorage = [[NSMutableArray alloc] init];
    self.playerRoles = [[NSMutableArray alloc] init];
    
    [self refreshCards];
    
    [self.deathSwitch addTarget:self action:@selector(deathToggled:) forControlEvents: UIControlEventValueChanged];
    
    // setup observers for nsnotification methods
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(ViewControllerShouldReloadNotification) name:@"ViewControllerShouldReloadNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(pullUpIndividualCard:) name:@"pullUpIndividualCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(updateNameOfCard:) name:@"updateNameOfCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(addDeadLabel) name:@"KillPlayer" object:nil];
    
    
    if([self.currentButtonText isEqualToString:@"Enter Day Time"]) {
        self.deathSwitchCase = YES;
        NSLog(@"about to enter day time");
        [self.beginDayButton setTitle: self.currentButtonText forState:UIControlStateNormal];
        self.beginDayButton.enabled = YES;
        self.beginNightButton.enabled = NO;
        self.continueDayButton.enabled = NO;
        [self.continueDayButton setTitle: @"Continue Day Time" forState:UIControlStateNormal];
        [self.beginNightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.continueDayButton setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
        [self.beginDayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.deathSwitch.enabled = YES;
        [self.deathSwitchLabel setTextColor:[UIColor redColor]];
    }
    else if([self.currentButtonText isEqualToString:@"Continue Day Time"]) {
        self.deathSwitchCase = YES;
        NSLog(@"about to continue day time");
        [self.continueDayButton setTitle: self.currentButtonText forState:UIControlStateNormal];
        self.beginDayButton.enabled = NO;
        self.beginNightButton.enabled = NO;
        self.continueDayButton.enabled = YES;
        [self.beginNightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.continueDayButton setTitleColor: [UIColor orangeColor] forState:UIControlStateNormal];
        [self.beginDayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.deathSwitch.enabled = YES;
        [self.deathSwitchLabel setTextColor:[UIColor redColor]];
    }
    // beginning start
    else {
        self.deathSwitchCase = NO;
        NSLog(@"beginning start");
        self.beginDayButton.enabled = NO;
        self.beginNightButton.enabled = YES;
        self.continueDayButton.enabled = NO;
        [self.beginNightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.beginDayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.continueDayButton setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
        self.deathSwitch.enabled = NO;
        [self.deathSwitchLabel setTextColor:[UIColor grayColor]];
    }
    
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"U WOT M8");
//
//
//}

// if gameover, performSegue which leads to another viewcontroller gameover
// play again leads back to player picker

// TODO: Need help figuring out when to call this method
//       and where to perform this segue
- (void)checkGameStatus {
    bool gameOver = false;
    bool allMafiaDead = false;
    int numAlive = 0;
    int numMafiaAlive = 0;
    
    SingleCard *tempCard;
    NSManagedObject *temp;

    for (temp in self.cardStorage) {
        tempCard = [temp valueForKey:@"oneCard"];
        
        if(tempCard.isAlive) {
            numAlive++;
            if(tempCard.role == 1) {
                numMafiaAlive++;
            }
        }
    }

    NSLog(@"NumAlive = %i\n NumMafiaAlive = %i\n", numAlive, numMafiaAlive);
    
    if(numMafiaAlive == 0) {
        allMafiaDead = true;
        gameOver = true;
    }
    else if(numMafiaAlive > numAlive - numMafiaAlive) {
        gameOver = true;
    }
    
    if(gameOver) {
        if(allMafiaDead) {
            //[self performSegueWithIdentifier : @"mafiaLoses" sender : tempCard];
        }
        else {
            //[self performSegueWithIdentifier : @"mafiaWins" sender : tempCard];
        }
    }
}

-(void)refreshCards {
    // Reload the cards
    if(self.didSetupCards == YES) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        // put the nsmanageobjects/datamodels into the contactList
        self.cardStorage = [[context executeFetchRequest:request error:nil] mutableCopy];
        
        // Call helper method checkGameStatus
        if(self.isDeathSwitchOn) {
            [self checkGameStatus];
        }
        
        SingleCard *tempCard;
        NSManagedObject *temp;
        // actually load the cards onto the screen...
        for (temp in self.cardStorage) {
            tempCard = [temp valueForKey:@"oneCard"];
            // changes color of a singleCard
            tempCard.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:tempCard];
            
            // [redux] enable the card touch to perform kill conditioned on whether the death switch is on or not

    
            // case for death switch
            if(self.deathSwitchCase == YES) {
                NSLog(@"death switch case");
                if(self.canDisableCard == NO) {
                    tempCard.userInteractionEnabled = YES;
                }
                else {
                    tempCard.userInteractionEnabled = NO;
                }
            }
        }
    }
    // Clean up the cards
    else {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        self.cardStorage = [[context executeFetchRequest:request error:nil] mutableCopy];
   
        SingleCard *tempCard;
        NSManagedObject *temp;
        for (temp in self.cardStorage) {
            tempCard = [temp valueForKey:@"oneCard"];
            [tempCard removeFromSuperview];
            [context deleteObject:temp];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setupCards : (NSDictionary *) cardSpecs AndLabels :(NSDictionary *) labelSpecs AndUpdate : (BOOL) update {
    
    // create roles and shuffle before assigning
    //
    // 1 - Mafia Role
    // 2 - Police Role
    // 3 - Innocent Role
    NSMutableArray *roles = [[NSMutableArray alloc] init];
    int numPlayers = (int)[cardSpecs count];
    int numMafia = 0;
    int numPolice = 1;
    int numInnocents = 0;

    if(numPlayers > 8) {
        numMafia = 3;
    }
    else {
        numMafia = 2;
    }
    
    numInnocents = numPlayers - numMafia - numPolice;

    // Add mafia
    for(int i = 0; i < numMafia; ++i) {
        [roles addObject:[NSNumber numberWithInt:1]];
    }
        
    // Add police
    for(int i = 0; i < numPolice; ++i) {
        [roles addObject:[NSNumber numberWithInt:2]];
    }
        
    // Add innocents
    for(int i = 0; i < numInnocents; ++i) {
       [roles addObject:[NSNumber numberWithInt:3]];
    }
    
    // Randomize roles that are to be assigned
    [roles shuffle];
    
    // remove any hanging cards from previous session
    [self refreshCards];
    
    int labelType;
    SingleCard *singleCard;
    NSInteger cardNumber = 1;
    
    CGFloat xCoord = 0.0;
    CGFloat yCoord = 0.0;
    CGFloat cardWidth = 0.0;
    CGFloat cardHeight = 0.0;
    
    CGFloat labelXCoord = 0.0;
    CGFloat labelYCoord = 0.0;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    // setup label for different sizes of cards
    NSDictionary *theLabel;
    if([labelSpecs objectForKey:@"labelType1"]) {
        theLabel = [labelSpecs objectForKey:@"labelType1"];
        labelType = 1;
    }
    else {
        theLabel = [labelSpecs objectForKey:@"labelType2"];
        labelType = 2;
    }
    
    labelXCoord = (CGFloat)[[theLabel objectForKey: @"xCoord"] floatValue];
    labelYCoord = (CGFloat)[[theLabel objectForKey: @"yCoord"] floatValue];
    labelWidth = (CGFloat)[[theLabel objectForKey: @"labelWidth"] floatValue];
    labelHeight = (CGFloat)[[theLabel objectForKey: @"labelHeight"] floatValue];
    
    NSInteger role_index = 0;
    
    // setup cards
    for(id key in cardSpecs) {
        NSDictionary *indivCard = [cardSpecs objectForKey:key];
        
        for(id attribute in indivCard) {
            // get the xCoord
            if([attribute isEqualToString:@"xCoord"]) {
                xCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            // get the yCoord
            else if([attribute isEqualToString:@"yCoord"]) {
                yCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            // get cardWidth
            else if([attribute isEqualToString:@"cardWidth"]) {
                cardWidth = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            // get cardHeight
            else if([attribute isEqualToString:@"cardHeight"]){
                cardHeight = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
        }
        // setup card
        CGRect cardSpec = CGRectMake(xCoord, yCoord, cardWidth, cardHeight);
        CGRect labelSpec = CGRectMake(labelXCoord, labelYCoord, labelWidth, labelHeight);
        singleCard = [[SingleCard alloc] init];
        
        NSInteger role = [[roles objectAtIndex:role_index] integerValue];
        role_index++;
        
        NSLog(@"Assinging role = %lu to player %lu", (long)role, (long)role_index);
        
        singleCard = [singleCard makeCard : cardSpec WithLabel: labelSpec AndType: labelType AndCardNumber : cardNumber AndRole : role];
        
        
//        SingleCardViewController *singleCardVC = [[SingleCardViewController alloc] init];
//        singleCard.delegate = singleCardVC;
        
        // Core Data stuff
        [CardsViewController saveCard : singleCard];
        
        // going to next card
        cardNumber++;
    }
    
    self.didSetupCards = update;
    if(self.didSetupCards == NO) {
        self.didSetupCards = YES;
    }
    
    [self refreshCards];
}

-(void) ViewControllerShouldReloadNotification {
    [self refreshCards];
}


// Core data under-the-hood method
+(void) saveCard : (SingleCard *) card {
    // and add the singleCard to Core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSManagedObject *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [newCard setValue : card forKey:@"oneCard"];
    // Save changes to the persistent store
    NSError *error;
    [context save:&error];
}

// NSNotification method
-(void) pullUpIndividualCard : (NSNotification *) cardSpec {
    NSDictionary *cardDict = [cardSpec userInfo];
    SingleCard *card = [cardDict objectForKey: @"card"];
    // temporary variable
    NSLog(@"pull up card");
    self.card = card;
    NSLog(@"%d", self.card.cardNumber);
    [self performSegueWithIdentifier : @"viewSingleCard" sender : card];
}

// NSNotification method
-(void) updateNameOfCard : (NSNotification *) cardSpec {
    NSLog(@"pls update name");
    NSDictionary *cardDict = [cardSpec userInfo];
    NSString *name = [cardDict objectForKey: @"playerName"];
    NSLog(@"%@", name);
    
    // access the core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Save changes to the persistent store
    NSError *error;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    tempArray = [[context executeFetchRequest :request error: &error] mutableCopy];
    SingleCard *tempCard;
    NSManagedObject *temp;
    for (temp in tempArray) {
        tempCard = [temp valueForKey:@"oneCard"];
        if(tempCard.cardNumber == self.card.cardNumber) {
            [tempCard.nameLabel setText: name];
            tempCard.name = name;
            tempCard.isSelected = YES;
            // Don't let the user select the card again
            tempCard.userInteractionEnabled = NO;
        }
    }
    [context save:&error];
}

-(void) addDeadLabel {
    // access the core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Save changes to the persistent store
    NSError *error;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    tempArray = [[context executeFetchRequest :request error: &error] mutableCopy];
    SingleCard *tempCard;
    NSManagedObject *temp;
    for (temp in tempArray) {
        tempCard = [temp valueForKey:@"oneCard"];
        if(tempCard.cardNumber == self.card.cardNumber) {
            [tempCard.nameLabel setText: @"Dead"];
            tempCard.isAlive = NO;
            tempCard.userInteractionEnabled = NO;
        }
    }
    [context save:&error];
}

// Trigged by toggle, and not be initial state
-(void) deathToggled:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
//        NSLog(@"its on!");
        self.isDeathSwitchOn = YES;
        self.canDisableCard = NO;
        [self refreshCards];
    }
    else {
//        NSLog(@"its off!");
        self.isDeathSwitchOn = NO;
        self.canDisableCard = YES;
        [self refreshCards];
    }
}

-(void) updatePlayButton : (NSString *) text AndCanTouchCard : (BOOL) canTouch{
    self.currentButtonText = text;
    self.didSetupCards = YES;
    // Can't access the card when kill is about to be made and when death switch is currently off
    if([text isEqualToString:@"Enter Day Time"] || [text isEqualToString:@"Continue Day Time"]) {
        self.canDisableCard = YES;
    }
    [self refreshCards];
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     if([segue isKindOfClass:[CustomSegue class]]) {
         // Set the start point for the animation to center of the button for the animation
         ((CustomSegue *)segue).originatingPoint = [sender getCenter];
         ((CustomSegue *)segue).card = sender;
         self.cardCenter = [sender getCenter];
     }
     // trigger message that restarts the card selections
     
//     else if([segue.identifier isEqualToString:@"beginGame"]) {
//         NSLog(@"sorta about to start game");
//         AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//         NSManagedObjectContext *context = appDelegate.managedObjectContext;
//         NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
//         NSFetchRequest *request = [[NSFetchRequest alloc] init];
//         [request setEntity:entityDescription];
//         
//         // put the nsmanageobjects/datamodels into the contactList
//         self.cardStorage = [[context executeFetchRequest:request error:nil] mutableCopy];
//         
//         SingleCard *tempCard;
//         NSManagedObject *temp;
//         // actually load the cards onto the screen...
//         for (temp in self.cardStorage) {
//             tempCard = [temp valueForKey:@"oneCard"];
//             if(tempCard.isSelected == NO) {
//                 [self performSegueWithIdentifier : @"playersNotFilledSegue" sender : self];
//             }
//         }
//     }
     
     NSLog(@"done?");
 }

// THIS IS REALLY HACKY...
// This is the IBAction method referenced in the Storyboard Exit for the Unwind segue.
// It needs to be here to create a link for the unwind segue.
// But we'll do nothing with it.
- (IBAction) unwindFromViewController:(UIStoryboardSegue *)sender {
    [self refreshCards];
}

// HACKY AGAIN, have to establish this unwind segue method in the navigation controller...
// We need to over-ride this method from UIViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    CustomUnwindSegue *segue = [[CustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point for the animation to the center of the button in this VC
    segue.targetPoint = [(CardsViewController*)toViewController getViewCenter];
    return segue;
}

-(CGPoint) getViewCenter {
    return self.cardCenter;
}

-(BOOL) getSwitchStatus {
    return self.isDeathSwitchOn;
}
 

@end
