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

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        for(id key1 in indivCard) {
            if([key1 isEqualToString:@"xCoord"]) {
                xCoord = (CGFloat)[[indivCard objectForKey:key1] floatValue];
            }
            else if([key1 isEqualToString:@"yCoord"]) {
                yCoord = (CGFloat)[[indivCard objectForKey:key1] floatValue];
            }
            else if([key1 isEqualToString:@"cardWidth"]) {
                cardWidth = (CGFloat)[[indivCard objectForKey:key1] floatValue];
            }
            else {
                // assumes cardHeight
                cardHeight = (CGFloat)[[indivCard objectForKey:key1] floatValue];
            }
        }
        CGRect cardSpec = CGRectMake(xCoord, yCoord, cardWidth, cardHeight);
        singleCard = [[SingleCard alloc] init];
        singleCard = [singleCard makeCard : cardSpec];
        
        // changes color of a singleCard
        singleCard.backgroundColor = [UIColor grayColor];
        
        // adds the singleCard to the [current] view
        [self.view addSubview:singleCard];
    }

    
    
}

@end
