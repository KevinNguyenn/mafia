//
//  CardsViewController.m
//  Mafia
//
//  Created by Kevin Nguyen on 10/28/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "CardsViewController.h"
#import "SingleCard.h"


@interface CardsViewController ()

@property (nonatomic, weak) NSString* currentButtonText;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.currentButtonText);
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
    }
    // beginning start
    else {
        [self.beginNightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.beginDayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.continueDayButton setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
        self.beginDayButton.enabled = NO;
        self.continueDayButton.enabled = NO;
        self.beginNightButton.enabled = YES;
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

-(void) setupCards : (NSDictionary *) cardSpecs {
    
    SingleCard *singleCard;
    CGFloat xCoord = 0.0;
    CGFloat yCoord = 0.0;
    CGFloat cardWidth = 0.0;
    CGFloat cardHeight = 0.0;
    for(id key in cardSpecs) {
        NSDictionary *indivCard = [cardSpecs objectForKey:key];
        for(id attribute in indivCard) {
            if([attribute isEqualToString:@"xCoord"]) {
                xCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else if([attribute isEqualToString:@"yCoord"]) {
                yCoord = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else if([attribute isEqualToString:@"cardWidth"]) {
                cardWidth = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
            else {
                // assumes cardHeight
                cardHeight = (CGFloat)[[indivCard objectForKey:attribute] floatValue];
            }
        }
        CGRect cardSpec = CGRectMake(xCoord, yCoord, cardWidth, cardHeight);
        singleCard = [[SingleCard alloc] init];
        singleCard = [singleCard makeCard : cardSpec];
        
        // changes color of a singleCard
        singleCard.backgroundColor = [UIColor greenColor];
        
        // adds the singleCard to the [current] view
        [self.view addSubview:singleCard];
    }
}

-(void) updatePlayButton : (NSString *) text {
    self.currentButtonText = text;
}

@end
