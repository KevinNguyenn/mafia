//
//  SingleCard.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/5/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCard.h"
#import "ViewController.h"

@implementation SingleCard

// card spec: width 75, height 112

-(id) init {
    self = [super init];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

-(id) makeCard : (CGRect) cardSpec {
    // TODO: change with differing cards?
    UIView *card = [[UIView alloc] initWithFrame: cardSpec];
    return card;
}


@end
