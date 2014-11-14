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

-(id) makeCard : (CGRect) cardSpec WithLabel : (CGRect) labelSpec AndType : (int)labelType{
    // TODO: change with differing cards?
    SingleCard *card = [[SingleCard alloc] initWithFrame: cardSpec];
    card.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame: labelSpec];
    
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    if(labelType == 1) {
       [nameLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 11.0f]];
    }
    else {
        [nameLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 10.0f]];
    }
    [nameLabel setText:@"Name"];
    
    nameLabel.autoresizingMask = card.autoresizingMask;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [card addSubview:nameLabel];
    
    
    self.cardHeight = cardSpec.size.width;
    self.cardWidth = cardSpec.size.width;
    self.xCoord = cardSpec.origin.x;
    self.yCoord = cardSpec.origin.y;
    card.userInteractionEnabled = YES;
    return card;
}

-(void) handleSingleTap:(UITapGestureRecognizer *)gr {
    NSLog(@"touched card!");
    NSDictionary *theCard = @{@"card": self};
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

-(CGPoint) getCenter {
    return self.center;
}





@end
