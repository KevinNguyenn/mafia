//
//  SingleCard.m
//  Mafia
//
//  Created by Kevin Nguyen on 11/5/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "SingleCard.h"
#import "ViewController.h"
#import "SingleCardViewController.h"

@implementation SingleCard

// card spec: width 75, height 112

-(id) init {
    self = [super init];
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

-(id) makeCard : (CGRect) cardSpec WithLabel : (CGRect) labelSpec AndType : (int)labelType AndCardNumber : (NSInteger) cardNumber AndRole : (NSInteger) role {
    
    SingleCard *card = [[SingleCard alloc] initWithFrame: cardSpec];
    card.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    card.nameLabel = [[UILabel alloc] initWithFrame: labelSpec];
    
    [card.nameLabel setTextColor:[UIColor blackColor]];
    [card.nameLabel setBackgroundColor:[UIColor clearColor]];
    
    if(labelType == 1) {
       [card.nameLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 12.0f]];
    }
    else {
        [card.nameLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 11.0f]];
    }
    
    [card.nameLabel setText:@"Name"];
    
    card.role = role;
    card.isAlive = true;
    
    card.nameLabel.autoresizingMask = card.autoresizingMask;
    card.nameLabel.textAlignment = NSTextAlignmentCenter;
    [card addSubview:card.nameLabel];
    card.cardNumber = cardNumber;
    card.cardHeight = cardSpec.size.width;
    card.cardWidth = cardSpec.size.width;
    card.xCoord = cardSpec.origin.x;
    card.yCoord = cardSpec.origin.y;
    card.userInteractionEnabled = YES;
    return card;
}

-(void) handleSingleTap : (UITapGestureRecognizer *)gr {
    NSLog(@"touched card!");
    NSDictionary *theCard = @{@"card": self};
    NSLog(@"%d", self.cardNumber);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pullUpIndividualCard" object:nil userInfo:theCard];
    
}

//-(void) handleDoubleMove:(UIPinchGestureRecognizer *)gr {
//    NSLog(@"handleDoubleMove");
//}

- (id)initWithFrame : (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // single tap
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer: singleTap];
        
        // 2 fingers pinch
//        UIPinchGestureRecognizer* doubleMove = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleMove:)];
//        
//        [self addGestureRecognizer: doubleMove];
    }
    return self;
}

-(UILabel*) getNameLabel {
    return self.nameLabel;
}

-(CGPoint) getCenter {
    return self.center;
}





@end
