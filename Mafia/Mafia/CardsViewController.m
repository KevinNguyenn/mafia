//
//  CardsViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 10/28/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CardsViewController.h"
#import "SingleCard.h"
#import "AppDelegate.h"



@interface CardsViewController ()

@property (nonatomic, weak) NSString* currentButtonText;
@property (nonatomic, strong) NSMutableArray *cardStorage;


@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cardStorage = [[NSMutableArray alloc] init];
    
    [self refreshCards];
    
    NSLog(@"setup observer");
    [[NSNotificationCenter defaultCenter] addObserver:self selector : @selector(ViewControllerShouldReloadNotification) name:@"ViewControllerShouldReloadNotification" object:nil];
    
    
    // Do any additional setup after loading the view.
    if([self.currentButtonText isEqualToString:@"Enter Day Time"]) {
        NSLog(@"about to enter day time");
        [self.beginDayButton setTitle: self.currentButtonText forState:UIControlStateNormal];
        self.beginDayButton.enabled = YES;
        self.beginNightButton.enabled = NO;
        self.continueDayButton.enabled = NO;
//        [self.beginNightButton setTitle: @"Begin Game" forState:UIControlStateNormal];
        [self.continueDayButton setTitle: @"Continue Day Time" forState:UIControlStateNormal];
        [self.beginNightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.continueDayButton setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
        [self.beginDayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.deathSwitch.enabled = YES;
        [self.deathSwitchLabel setTextColor:[UIColor redColor]];
    }
    else if([self.currentButtonText isEqualToString:@"Continue Day Time"]) {
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

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//}

- (void)refreshCards {
    if(self.didSetupCards == YES) {
        NSLog(@"persist the cards");
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        // put the nsmanageobjects/datamodels into the contactList
        self.cardStorage = [[context executeFetchRequest:request error:nil] mutableCopy];
        
        SingleCard *tempCard;
        NSManagedObject *temp;
        // actually load the cards onto the screen...
        for (temp in self.cardStorage) {
            tempCard = [temp valueForKey:@"oneCard"];
            // changes color of a singleCard (SET GREEN FOR REFERENCE)
            tempCard.backgroundColor = [UIColor blueColor];
            [self.view addSubview:tempCard];
        }
    }
    else {
        NSLog(@"clean up cards");
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        self.cardStorage = [[context executeFetchRequest:request error:nil] mutableCopy];
        int c = 0;
        SingleCard *tempCard;
        NSManagedObject *temp;
        // actually load the cards onto the screen...
        for (temp in self.cardStorage) {
            NSLog(@"%d", c);
            tempCard = [temp valueForKey:@"oneCard"];
            [tempCard removeFromSuperview];
            [context deleteObject:temp];
            c++;
        }
    }
    
 
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

-(void) setupCards : (NSDictionary *) cardSpecs AndUpdate : (BOOL) update {
    // remove any hanging cards from previous session
    [self refreshCards];
    
    SingleCard *singleCard;
    CGFloat xCoord = 0.0;
    CGFloat yCoord = 0.0;
    CGFloat cardWidth = 0.0;
    CGFloat cardHeight = 0.0;
    for(id key in cardSpecs) {
        NSDictionary *indivCard = [cardSpecs objectForKey:key];
        for(id attribute in indivCard) {
            if([attribute isEqualToString:@"xCoord"]) {
                // get the xCoord
                xCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else if([attribute isEqualToString:@"yCoord"]) {
                // get the yCoord
                yCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else if([attribute isEqualToString:@"cardWidth"]) {
                // get cardWidth
                cardWidth = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else {
                // assumes to get cardHeight
                cardHeight = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
        }
        // setup card
        CGRect cardSpec = CGRectMake(xCoord, yCoord, cardWidth, cardHeight);
        singleCard = [[SingleCard alloc] init];
        singleCard = [singleCard makeCard : cardSpec];
        
        
        // and add the singleCard to Core data
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSManagedObject *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
        
        [newCard setValue:singleCard forKey:@"oneCard"];
   
        
        // Save changes to the persistent store
        NSError *error;
        [context save:&error];
    }
    
    self.didSetupCards = update;
    if(self.didSetupCards == NO) {
        self.didSetupCards = YES;
    }
    
    [self refreshCards];
}

-(void) updatePlayButton : (NSString *) text {
    self.currentButtonText = text;
    self.didSetupCards = YES;
    [self refreshCards];
}



-(void) ViewControllerShouldReloadNotification {
    [self refreshCards];
}




@end
